class Admin 
  # < ApplicationRecord
  def self.approve(ad)
    adopted = Pet.find(ad.pet_id)
    # binding.pry
    adopted.update!(adoptable: false)
  end
end