class RegisteredApplicationsController < ApplicationController
  def index
    @applications = RegisteredApplication.all
  end

  def show
    @application = RegisteredApplication.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @application = RegisteredApplication.new
  end

  def create
    @user = User.find(params[:user_id])
    @application = @user.registered_application.build(app_params)

    if @application.save
      flash[:notice] = "Registered application was saved."
      redirect_to user_path(@user)
    else
      #
    end
  end

  def destroy
  end

  private

  def app_params
    params.require(@application).permit(:name, :url)
  end
end
