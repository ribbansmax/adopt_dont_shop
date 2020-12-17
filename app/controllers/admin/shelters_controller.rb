class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order(name: :desc)
  end

  def show
    @shelter = Shelter.find(params[:id])
  end
end
