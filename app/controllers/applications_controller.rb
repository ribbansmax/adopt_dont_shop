class ApplicationsController < ApplicationController
  include EmptyForm
  
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    if errors = check(application_params)
      redirect_to new_app_path, notice: "Application is missing: #{errors}"
    else
      app = Application.create(application_params)
      redirect_to show_app_path(app.id)
    end
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip)
  end
end