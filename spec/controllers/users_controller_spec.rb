require 'rails_helper'
require_relative '../../lib/confirmation_sender'

describe UsersController do
  describe "#new" do
    it "renders new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assings an instance of User" do
      get :new
      expect(assigns[:user]).to be_an_instance_of(User)
    end
  end

  describe "#create" do
    context 'when required information is complete' do
      before do
        allow(ConfirmationSender).to receive(:send_confirmation_message_to)
        post :create, user: attributes_for(:user)
      end

      it 'creates a user' do
        expect(User.count).to eq(1)
      end

      it 'renders confirmation' do
        expect(response).to render_template(:confirmation)
      end

      it 'sends confirmation message to the user' do
        expect(ConfirmationSender)
          .to have_received(:send_confirmation_message_to)
          .once
      end
    end

    context 'when required information is incomplete' do
      before do
        post :create, user: attributes_for(:user).except(:email)
      end

      it 'do not create a user' do
        expect(User.count).to eq(0)
      end

      it 'renders new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#confirm" do
    let(:user) { create(:user, verification_code: '110294') }

    context 'when verification code is correct' do
      before do
        confirm_params = {
          user_id: user.id,
          verification_code: user.verification_code
        }

        post :confirm, confirm_params
      end

      it 'updates confirmed to true' do
        expect(User.last.confirmed).to be_truthy
      end

      it 'authenticates the user' do
        expect(session[:authenticated]).to be_truthy
      end

      it 'redirects to secrets_path' do
        expect(response).to redirect_to(secrets_path)
      end
    end

    context 'when verification code is incorrect' do
      before do
        confirm_params = {
          user_id: user.id,
          verification_code: '000000'
        }

        post :confirm, confirm_params
      end

      it 'does not change confirmed' do
        expect(User.last.confirmed).to be_falsey
      end

      it 'renders confirmation template' do
        expect(response).to render_template(:confirmation)
      end
    end
  end
end
