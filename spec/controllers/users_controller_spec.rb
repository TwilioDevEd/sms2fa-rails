require 'rails_helper'

describe UsersController do
  render_views
  
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

      expect(response.body).to match /\+1-555-5555/im
    end
    
    it "sends activation code to phone number" do
      allow(CodeGenerator).to receive(:generate).and_return('123456')
      
      expect(MessageSender).to receive(:send_code).with('+1-555-5555', '123456')
      
      post :create, valid_user_attributes
    end
  end

  describe "#confirm" do
    render_views
    it "validates user with correct verification code" do
      user = double("user", verification_code: '123456')
      allow(User).to receive(:find).and_return(user)
      
      expect(user).to receive(:update)
      
      post :confirm, {user_id: 1, verification_code: user.verification_code}
    end

    it "redirects user to top secret content after successful validation" do
      user = double("user", verification_code: '123456')
      allow(User).to receive(:find).and_return(user)
      allow(user).to receive(:update)
           
      post :confirm, {user_id: 1, verification_code: user.verification_code}

      expect(response.body).to match /Top Secret Content/im
    end

    it "renders confirmation page if code doesnt match" do
      user = double("user", verification_code: '123456', phone_number: '+55 123', id: 1)
      allow(User).to receive(:find).and_return(user)
      allow(user).to receive(:update)
           
      post :confirm, {user_id: 1, verification_code: '1337'}

      expect(response.body).to match /please enter the 6-digits activation code/im
    end
  end
end
