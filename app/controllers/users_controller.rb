class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @registered_applications = @user.registered_applications
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      flash[:notice] = "Welcome to Blocmetrics #{@user.name}!"
      log_in(@user)
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "There was an error creating your account. Please try again."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
