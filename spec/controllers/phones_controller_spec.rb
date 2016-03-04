require 'rails_helper'
require 'code_generator'
require 'message_sender'

describe PhonesController do
  describe "#activate" do
    it "sends activation code to phone number" do
      allow(CodeGenerator).to receive(:generate).and_return('123456')
      user = double(User, phone_number: '00000000')
      allow(User).to receive(:find).and_return(user)
      
      expect(MessageSender).to receive(:send_code).with(user.phone_number, '123456')
      
      post :activate, user_id: 1 
    end
  end
end
