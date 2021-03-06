class UsersController < ApplicationController
  # before_action :authorize_user, :except => [:index]

  def show
    @user = User.find(params[:id])
    @registered_applications = @user.registered_applications
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      log_in(@user)
      UserMailer.welcome_email(@user).deliver_now
      flash[:notice] = "Welcome to Blocmetrics #{@user.name}!"
      redirect_to @user
    else
      flash.now[:danger] = "There was an error creating your account. Please try again."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def authorize_user
    signed_in_user = User.find(params[:id])
    unless current_user == signed_in_user
      flash[:alert] = "You are not authorized to view that page."
      redirect_to root_path
    end
  end
end
