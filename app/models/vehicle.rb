class Vehicle < ApplicationRecord
  has_many :locations, -> { order(:at) }, dependent: :destroy

  validates :uuid, uniqueness: true, presence: true

  def to_param
    uuid
  end
end
