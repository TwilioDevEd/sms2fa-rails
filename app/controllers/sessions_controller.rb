class SessionsController < ApplicationController

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:authenticated] = false
      render "users/confirmation"
    else
      render nothing: true
    end
  end

  def new
  end
end
