class RegisteredApplicationsController < ApplicationController
  before_action :set_user
  before_action :authorize_user, only: [:destroy]

  def show
    @application = RegisteredApplication.find(params[:id])
  end

  def new
    @application = RegisteredApplication.new
  end

  def create
    @application = @user.registered_applications.new(app_params)
    @application.name.capitalize!
    @application.save

    if @application.save
      redirect_to user_path(@user), notice: "#{@application.name} has been registered."
    else
      flash.now[:alert] = "There was an error registering the application.  Please try again."
      render :new
    end
  end

  def destroy
    @application = @user.registered_applications.find(params[:id])

    if @application.destroy
      flash[:notice] = "#{@application.name} has been removed from registry list."
      redirect_to user_path(@user)
    else
      flash[:alert] = "Application could not be de-registered. Please try again."
    end
  end

  private

  def app_params
    params.require(:registered_application).permit(:name, :url)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def authorize_user
    registered_application = RegisteredApplication.find(params[:id])
    unless current_user == registered_application.user
      flash[:alert] = "You do not have permission to remove this application."
      redirect_to [registered_application.user, registered_application]
    end
  end
end
