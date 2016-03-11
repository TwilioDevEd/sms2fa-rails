class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:authenticated] = false
      ConfirmationSender.send_confirmation_to @user

      redirect_to new_confirmation_path
    else
      flash.now[:error] = "Wrong user/password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:authenticated] = nil
    flash.now[:notice] = "See you soon!"
    render :new
  end
end
