class Location < ApplicationRecord
  belongs_to :vehicle

  validates :latitude, :longitude, :time, :vehicle, presence: true
  validates :time, uniqueness: { scope: :vehicle_id }
end
