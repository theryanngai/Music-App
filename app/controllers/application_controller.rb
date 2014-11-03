class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :login_user!

  def current_user
  	User.find_by_session_token(session[:token])
  end

  def logged_in?
  	!session[:token].nil?
  end

  def login_user!(user)
  	session[:token] = user.reset_session_token!
  	user.save
  	redirect_to bands_url
  end

  private
  def verify_logged_in
    redirect_to new_session_url unless logged_in?
  end
end
