class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def signed_in?
    User.find(session[:user_id]) && session[:authenticated]
  end

  def authenticate!
    redirect_to login_path and return unless signed_in?
  end
end
