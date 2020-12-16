class Adoption < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.status(app_id)
    if Adoption.where(application_id: app_id).select(:approved).all? {|adopt| adopt[:approved] == true}
      app = Application.find(app_id)
      app.update(approved: true)
      app.status
    elsif Adoption.where(application_id: app_id).select(:approved).any? {|adopt| adopt[:approved] == false}
      app = Application.find(app_id)
      app.update(approved: false)
      app.status
    else
      "Pending"
    end
  end
end