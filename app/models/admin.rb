class Admin < ApplicationRecord
  def self.approve(adopted)
    adopted.update!(approved: true)
  end
end