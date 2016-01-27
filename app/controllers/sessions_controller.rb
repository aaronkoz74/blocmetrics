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
    # user = User.authenticate(params[:email], params[:password])
    # if user
      log_in user
      flash.now[:notice] = "#{user.name}, you are now logged in!"
      redirect_to user_path(user)

    else
      flash.now[:alert] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    log_out
    cookies.delete(:auth_token)
    redirect_to root_path, :notice => "You've been logged out, come back soon!"
  end
end
