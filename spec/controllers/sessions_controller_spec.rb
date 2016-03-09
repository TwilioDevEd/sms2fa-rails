require 'rails_helper'

describe SessionsController do
  describe "#create" do
    render_views

    it "persist user id in the session if password is right" do
      user = double("User", id: 123, update: true, password: "123", phone_number: "00000000")
      allow(User).to receive(:find_by).with(email: "teste@example.com").and_return(user)
      allow(user).to receive(:authenticate).with('123').and_return(true)
      allow(MessageSender).to receive(:send_code)

      post :create, {email: "teste@example.com", password: "123"} 

      expect(session[:user_id]).to be user.id
    end

    it "send a new random code to confirm" do
      user = double("User", id: 123, update: true, password: "123", phone_number: "00000000")
      allow(User).to receive(:find_by).with(email: "teste@example.com").and_return(user)
      allow(user).to receive(:authenticate).with('123').and_return(true)
      allow(CodeGenerator).to receive(:generate).and_return('123456')
      allow(MessageSender).to receive(:send_code)
      
      expect(MessageSender).to receive(:send_code).with('00000000', '123456')
      post :create, {email: "teste@example.com", password: "123"} 
    end

    it "redirects to the confirmation page" do
      user = double("User", id: 123, update: true, password: "123", phone_number: "00000000")
      allow(User).to receive(:find_by).with(email: "teste@example.com").and_return(user)
      allow(user).to receive(:authenticate).with('123').and_return(true)
      allow(MessageSender).to receive(:send_code)

      post :create, {email: "teste@example.com", password: "123"} 

      expect(response.body).to match(/enter the 6-digits activation code/mi)
    end

    it "redirects to the login page if user/password is not correct" do
      user = double("User", id: 123, phone_number: "00000000")
      allow(User).to receive(:find_by).with(email: "teste@example.com").and_return(user)
      allow(user).to receive(:authenticate).with('456').and_return(false)

      post :create, {email: "teste@example.com", password: "456"} 

      expect(response.body).to match(/email/mi)
    end
  end
end
