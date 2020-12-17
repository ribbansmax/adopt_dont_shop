class Application < ApplicationRecord
  has_many :adoptions
  has_many :pets, through: :adoptions

  validates_presence_of :name, :address, :city, :state

  def status
    if self.approved
      "Approved"
    elsif (self.approved == false)
      "Rejected"
    elsif self.completed
      "Pending"
    else
      "In Progress"
    end
  end

  def claim_pets
    pets.each do |pet|
      pet.update!(adoptable: false)
    end
  end
end