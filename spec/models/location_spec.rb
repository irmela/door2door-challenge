require 'rails_helper'

RSpec.describe Location, type: :model do
  it { is_expected.to validate_presence_of(:lat) }
  it { is_expected.to validate_presence_of(:lng) }
  it { is_expected.to validate_presence_of(:at) }
  it { is_expected.to validate_presence_of(:vehicle) }
  it { is_expected.to validate_uniqueness_of(:at).scoped_to(:vehicle_id) }
  it { is_expected.to belong_to(:vehicle) }
end
