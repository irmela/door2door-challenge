class Vehicle < ApplicationRecord
  validates :uuid, uniqueness: true
end
