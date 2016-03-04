class PhonesController < ApplicationController

  def activate
    user = User.find(params[:id])
    activation_code = CodeGenerator.generate
    MessageSender.send_code(user.phone_number, activation_code)
    
    render nothing: true
  end
end
