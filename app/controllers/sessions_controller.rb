class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:authenticated] = false
      verification_code = CodeGenerator.generate
      @user.update(verification_code: verification_code) 
      MessageSender.send_code(@user.phone_number, verification_code)

      render 'users/confirmation'
    else
      render :new
    end
  end

  def new
  end
end
