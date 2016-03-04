require 'rails_helper'

describe UsersController do
  describe "#new" do
    it "renders new" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assings an instance of User" do
      get :new
      expect(assigns(:user)).to be_an_instance_of(User)
    end
  end

  describe "#create" do
    # :( create a user / show the new form
    it "renders new when user is not saved" do
      # user = mock_model(User)
      # allow(User).to receive(:new).and_return(user)
      # allow(user).to receive(:save).and_return(false)
      user_attributes = {
        user: {
          last_name: 'martin',
          email: 'bob@martin.com',
          phone_number: '+1-555-5555',
          password: 'very-secret-password'
        }
      }

      post :create, user_attributes

      expect(response).to render_template(:new)
    end

    # :) create a user / redirect verify phone form
    it "redirects to verify_phone_path when user is saved" do
      user_attributes = {
        user: {
          first_name: 'bob',
          last_name: 'martin',
          email: 'bob@martin.com',
          phone_number: '+1-555-5555',
          password: 'very-secret-password'
        }
      }

      post :create, user_attributes

      expect(response).to redirect_to(new_user_path)
    end
  end
end
