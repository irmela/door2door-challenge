class Vehicle < ApplicationRecord
  has_many :locations, dependent: :destroy

  validates :uuid, uniqueness: true
end
