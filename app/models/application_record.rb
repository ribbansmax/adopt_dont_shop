class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(find)
    key = "%#{find}%"
    if key != ""
      self.where("lower(name) like lower(?)", key)
    end
  end

  def full_address
    "#{self.address} #{self.city}, #{self.state} #{self.zip}"
  end
end
