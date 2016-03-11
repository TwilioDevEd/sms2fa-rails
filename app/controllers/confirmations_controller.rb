class ConfirmationsController < ApplicationController
  def new
    @user = User.find(session[:user_id])
  end

  def create
    @user = User.find params[:user_id]
    if @user.verification_code == params[:verification_code]
      @user.confirm!
      session[:authenticated] = true
      redirect_to secrets_path
    else
      flash[:error] = "Verification code is incorrect."
      render :new
    end
  end
end
