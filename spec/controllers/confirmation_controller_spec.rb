require 'rails_helper'

describe ConfirmationController do
  let(:user) { create(:user, verification_code: '110294') }

  describe '#new' do
    before { get :new, nil, user_id: user.id }

    it 'renders new template' do
      expect(response).to render_template(:new)
    end

    it 'assings a user to @user' do
      expect(assigns[:user]).to eq(user)
    end
  end

  describe "#create" do
    context 'when verification code is correct' do
      before do
        confirm_params = {
          user_id: user.id,
          verification_code: user.verification_code
        }

        post :create, confirm_params
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

        post :create, confirm_params
      end

      it 'does not change confirmed' do
        expect(User.last.confirmed).to be_falsey
      end

      it 'renders confirmation template' do
        expect(response).to render_template(:new)
      end
    end
  end
end
