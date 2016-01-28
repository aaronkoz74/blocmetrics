class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in(user)
      remember(user)
      flash.now[:notice] = "#{user.name}, you are now logged in!"
      redirect_to user

    else
      flash.now[:danger] = "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path, :notice => "You've been logged out, come back soon!"
  end
end
