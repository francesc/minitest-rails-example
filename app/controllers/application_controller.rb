class ApplicationController < ActionController::Base
  protect_from_forgery

protected

  def current_user
    if session[:user_id]
      User.find_by_id(session[:user_id])
    end
  end
  helper_method :current_user
end
