require 'rails_helper'

RSpec.describe Location, type: :model do
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:vehicle) }
  it { should validate_uniqueness_of(:time).scoped_to(:vehicle_id) }
end
