class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order(name: :desc)
    @pending_shelters = @shelters.pending
  end

  def show
    @shelter = Shelter.find(params[:id])
    @shelter_address = @shelter.full_address
    @pending_pets = @shelter.pending_pets
  end
end
