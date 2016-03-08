require 'rails_helper'

describe SecretContentsController do
  describe "#show" do
    render_views
    it "should redirect when user is not logged in" do
      user = double("User")
      allow(User).to receive(:find).and_return(user)
      get :show
      expect(response).to redirect_to('login')
    end
    it "show content if user is authenticated" do
      user = double("User")
      allow(User).to receive(:find).with(1).and_return(user)
      get :show, nil, {user_id: 1, authenticated: true}
      expect(response.body).to match /Top Secret/im
    end
  end
end
