class AdoptionsController < ApplicationController
  def create
    Adoption.create!(application_id: params[:app_id], pet_id: params[:pet_id])
    redirect_to "/applications/#{params[:app_id]}"
  end

  def update
    adopt = Adoption.find(params[:id])
    if params[:reject] == "true"
      adopt.update!(approved: false)
      redirect_to "/admin/applications/#{params[:app]}"
    else
      adopt.update!(approved: true)
      redirect_to "/admin/applications/#{params[:app]}"
    end
  end
end