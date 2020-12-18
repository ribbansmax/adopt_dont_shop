class Shelter < ApplicationRecord
  has_many :pets

  def self.pending
    pending_apps = Application.where(completed: true, approved: nil).select(:id)
    pending_pets = Adoption.where(application_id: pending_apps).select(:pet_id)
    shelter_ids = Pet.where(id: pending_pets).select(:shelter_id)
    Shelter.where(id: shelter_ids)
  end

  def pending_pets
    pets.joins(:adoptions).where("adoptions.approved is NULL").select("pets.*, adoptions.application_id as app_id")
  end

  def average_pet_age
    pets.average(:approximate_age)
  end

  def adopted_pets
    pets.where(adoptable: false).count
  end

  def adoptable_pets
    pets.where(adoptable: true).count
  end
end
