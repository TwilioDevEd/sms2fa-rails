class SessionsController < ApplicationController

  def create
    @user = User.find(email: params[:email])
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      session[:authenticated] = false
      render "users/confirmation"
    else
      render nothing: true
    end
  end
end
