require 'rails_helper'

describe UsersController do
  
  valid_user_attributes = {
    user: {
      first_name: 'bob',
      last_name: 'martin',
      email: 'bob@martin.com',
      phone_number: '+1-555-5555',
      password: 'very-secret-password'
    }
  }

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
    it "renders new when user is not saved" do
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

    it "redirects to verify_phone_path when user is saved" do
      allow(MessageSender).to receive(:send_code)

      post :create, valid_user_attributes

      expect(response).to redirect_to(new_user_path)
    end
    
    it "sends activation code to phone number" do
      allow(CodeGenerator).to receive(:generate).and_return('123456')
      
      expect(MessageSender).to receive(:send_code).with('+1-555-5555', '123456')
      
      post :create, valid_user_attributes
    end
  end
end
