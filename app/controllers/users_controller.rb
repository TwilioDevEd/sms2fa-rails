class UsersController < ApplicationController
  ATTRIBUTE_WHITELIST = [
    :first_name,
    :last_name,
    :email,
    :phone_number,
    :password_confirmation,
    :password
  ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      ConfirmationSender.send_confirmation_message_to(@user)
      render :confirmation
    else
      render :new
    end
  end

  def confirm
    @user = User.find params[:user_id]
    if @user.verification_code == params[:verification_code]
      @user.update(confirmed: true)
      session[:authenticated] = true
      redirect_to secrets_path
    else
      flash[:error] = "Verification code is incorrect."
      render :confirmation
    end
  end

  private

  def user_params
    params.require(:user).permit(*ATTRIBUTE_WHITELIST)
  end
end
