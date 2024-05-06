require 'rails_helper'

describe SecretsController do
  shared_examples "#index" do
    let(:user) { create(:user) }

    context 'when user is authenticated' do
      it 'renders protected content' do
        get :index, params: { user_id: user.id, authenticated: true }
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to new_session_path' do
        get :index, params: { user_id: user.id, authenticated: false }
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end
