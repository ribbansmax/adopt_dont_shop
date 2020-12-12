class Adoption < ApplicationRecord
  belongs_to :pet
  belongs_to :application
end