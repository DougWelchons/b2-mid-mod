require 'rails_helper'

RSpec.describe Ride, type: :model do
  describe 'validations' do
    it { should have_many(:ride_mechanics) }
    it { should have_many(:mechanics).through(:ride_mechanics) }
  end
end
