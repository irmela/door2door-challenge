class Location < ApplicationRecord
  belongs_to :vehicle

  validates :lat, :lng, :at, :vehicle, presence: true
  validates :at, uniqueness: { scope: :vehicle_id }
end
