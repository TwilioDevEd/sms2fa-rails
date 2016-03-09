module ConfirmationSender
  def ConfirmationSender.send_confirmation_message_to(user)
    verification_code = CodeGenerator.generate
    user.update(verification_code: verification_code) 
    MessageSender.send_code(user.phone_number, verification_code)
  end
end
