class Admin < ApplicationRecord
  def self.approve(ad)
    adopted = ad
    adopted.update!(approved: true)
  end
end