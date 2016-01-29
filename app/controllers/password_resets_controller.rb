class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_path, notice: "Email has been sent with instructions for resetting your password."
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: "Password reset has expired."
    elsif @user.update_attributes(user_password_params)
      redirect_to login_path, notice: "Your password has been reset - please log in."
    else
      render :edit
    end
  end

  private

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
