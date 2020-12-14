class AdoptionsController < ApplicationController
  def create
    Adoption.create!(application_id: params[:app_id], pet_id: params[:pet_id])
    redirect_to "/applications/#{params[:app_id]}"
  end
end