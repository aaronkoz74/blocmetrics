class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      log_in(user)
      redirect_to user_path(user), :notice => "#{user.name}, you are now signed in!"

    else
      flash.now[:alert] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    log_out(current_user)
    cookies.delete(:auth_token)
    redirect_to root_path, :notice => "You've been signed out, come back soon!"
  end
end
