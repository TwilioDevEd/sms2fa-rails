require 'code_generator'
require 'message_sender'

class UsersController < ApplicationController
  WHITELIST_ATTRIBUTES = [
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
      render :top_secret
    else
      render :confirmation
    end
  end

  private

  def user_params
    params.require(:user).permit(*WHITELIST_ATTRIBUTES)
  end
end
