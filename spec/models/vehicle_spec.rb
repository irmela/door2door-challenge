require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it { should validate_uniqueness_of(:uuid) }
  it { should validate_presence_of(:uuid) }
end
