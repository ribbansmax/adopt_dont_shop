class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(find)
    key = "%#{find}%"
    if key != ""
      self.where("lower(name) like lower(?)", key)
    end
  end
end
