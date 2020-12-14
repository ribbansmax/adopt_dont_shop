class ApplicationsController < ApplicationController
  include EmptyForm
  
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    if params["commit"] == "search"
      @found_pets = Pet.search(search_params[:search])
    elsif params["commit"] == 'adopt this pet'
      @application.add_pet(para)
    else
      @found_pets = []
    end
  end

  def update
    application = Application.find(params[:id])
    if application.pets.empty?
      redirect_to show_app_path, notice: "Please submit once you have finished choosing pets to adopt."
    elsif params["describe"].length <= 10
      redirect_to show_app_path, notice: "Please submit once you have described why you are a good choice for these pets."
    else
      application.update!(completed: :true, description: params[:describe])
      redirect_to show_app_path
    end
  end

  def add_pet
    binding.pry
    Adoption.create!(application_id: params[:id], pet_id: params[:pet_id])
    redirect_to show_app_path(params[:id])
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

  def search_params
    params.permit(:search)
  end
end