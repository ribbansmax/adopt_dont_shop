class Shelter < ApplicationRecord
  has_many :pets

  def self.pending
    pending_apps = Application.where(completed: true, approved: nil).select(:id)
    pending_pets = Adoption.where(application_id: pending_apps).select(:pet_id)
    shelter_ids = Pet.where(id: pending_pets).select(:shelter_id)
    Shelter.where(id: shelter_ids)
  end

  def average_pet_age
    pets.average(:approximate_age)
  end
end
