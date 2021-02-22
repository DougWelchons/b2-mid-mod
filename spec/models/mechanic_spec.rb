require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  describe 'validations' do
    it { should have_many(:ride_mechanics) }
    it { should have_many(:rides).through(:ride_mechanics) }
  end

  describe "Class methods" do
    before :each do
      @mechaninc1 = Mechanic.create!(name: "Mechaninc1", years_experience: 1)
      @mechaninc2 = Mechanic.create!(name: "Mechaninc2", years_experience: 2)
    end

    it ".average_experience" do
      expect(Mechanic.average_experience).to eq(1.5)
    end
  end

  describe "istance methods" do
    before :each do
      @mechaninc1 = Mechanic.create!(name: "Mechaninc1", years_experience: 1)
      @mechaninc2 = Mechanic.create!(name: "Mechaninc2", years_experience: 2)

      @ride1 = Ride.create!(name: "ride1", thrill_rating: 1, open: true)
      @ride2 = Ride.create!(name: "ride2", thrill_rating: 2, open: false)
      @ride3 = Ride.create!(name: "ride3", thrill_rating: 3, open: true)

      @rm1 = RideMechanic.create!(ride: @ride1, mechanic: @mechaninc1)
      @rm2 = RideMechanic.create!(ride: @ride2, mechanic: @mechaninc1)
      @rm3 = RideMechanic.create!(ride: @ride3, mechanic: @mechaninc1)
    end

    it "#sorted_open_rides" do
      expect(@mechaninc1.sorted_open_rides).to eq([@ride3, @ride1])
    end
  end
end
