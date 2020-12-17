class Application < ApplicationRecord
  has_many :adoptions
  has_many :pets, through: :adoptions

  validates_presence_of :name, :street_address, :city, :state

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

  def address
    "#{self.street_address} #{self.city}, #{self.state} #{self.zip}"
  end

  def claim_pets
    pets.each do |pet|
      pet.update!(adoptable: false)
    end
  end
end