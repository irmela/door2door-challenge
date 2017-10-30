require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it { is_expected.to validate_uniqueness_of(:uuid) }
  it { is_expected.to validate_presence_of(:uuid) }
  it { is_expected.to have_many(:locations) }
end
