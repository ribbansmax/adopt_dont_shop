class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @adoptions = Adoption.where(application_id: params[:id])
  end
end