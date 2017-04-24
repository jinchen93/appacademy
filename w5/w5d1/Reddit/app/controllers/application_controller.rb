class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :moderator?, :signed_in?

  def login(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end

  def ensure_logged_in
    redirect_to root_url unless current_user
  end

  def signed_in?
    !!current_user
  end

  def moderator?
    @sub = Sub.find_by(title: params[:title])
    @sub.moderator == current_user
  end
end
