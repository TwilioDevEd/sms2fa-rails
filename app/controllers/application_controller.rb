class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticated?
    session[:user_id] && session[:authenticated]
  end

  def authenticate!
    redirect_to new_session_path and return unless authenticated?
  end

  helper_method :authenticated?
end
