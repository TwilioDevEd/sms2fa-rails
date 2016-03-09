require 'confirmation_sender'

class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:authenticated] = false
      ConfirmationSender.send_confirmation_message_to @user
      render 'users/confirmation'
    else
      flash[:error] = "Wrong user/password."
      render :new
    end
  end

  def new
  end
end
