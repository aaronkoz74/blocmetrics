module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session[:user_id] = nil
  end

  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
end
