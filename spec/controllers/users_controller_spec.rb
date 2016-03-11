require 'rails_helper'

describe UsersController do
  describe "#new" do
    before { get :new }

    it "renders new template" do
      expect(response).to render_template(:new)
    end

    it "assings an instance of User" do
      expect(assigns[:user]).to be_an_instance_of(User)
    end
  end

  describe "#create" do
    context 'when required information is complete' do
      before do
        allow(ConfirmationSender).to receive(:send_confirmation_to)
        post :create, user: attributes_for(:user)
      end

      it 'creates a user' do
        expect(User.count).to eq(1)
      end

      it 'stores user_id in session' do
        expect(session[:user_id]).to eq(User.last.id)
      end

      it 'redirects to new_confirmation_path' do
        expect(response).to redirect_to(new_confirmation_path)
      end

      it 'sends confirmation message to the user' do
        expect(ConfirmationSender)
          .to have_received(:send_confirmation_to)
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
end
