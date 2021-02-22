require 'rails_helper'

RSpec.describe "Mechanic index page" do
  before :each do
    @mechaninc1 = Mechanic.create!(name: "Mechaninc1", years_experience: 1)

    @ride1 = Ride.create!(name: "ride1", thrill_rating: 1, open: true)
    @ride2 = Ride.create!(name: "ride2", thrill_rating: 2, open: false)
    @ride3 = Ride.create!(name: "ride3", thrill_rating: 3, open: true)
    @ride4 = Ride.create!(name: "ride4", thrill_rating: 4, open: true)
    @ride5 = Ride.create!(name: "ride5", thrill_rating: 5, open: true)

    @rm1 = RideMechanic.create!(ride: @ride1, mechanic: @mechaninc1)
    @rm2 = RideMechanic.create!(ride: @ride2, mechanic: @mechaninc1)
    @rm3 = RideMechanic.create!(ride: @ride3, mechanic: @mechaninc1)
    @rm4 = RideMechanic.create!(ride: @ride4, mechanic: @mechaninc1)
  end

  describe "when I visit the mechanic show page" do
    it "shows there name, years of experiance, and all the rides they work on" do
      visit "/mechanics/#{@mechaninc1.id}"

      expect(page).to have_content("Name: Mechaninc1")
      expect(page).to have_content("Years of experience: 1")

      within(".rides") do
        expect(@ride4.name).to appear_before(@ride3.name)
        expect(@ride3.name).to appear_before(@ride1.name)

        within("#ride_#{@ride1.id}") do
          expect(page).to have_content("Name: #{@ride1.name}")
          expect(page).to have_content("Thrill rating: #{@ride1.thrill_rating}")
        end

        within("#ride_#{@ride3.id}") do
          expect(page).to have_content("Name: #{@ride3.name}")
          expect(page).to have_content("Thrill rating: #{@ride3.thrill_rating}")
        end

        within("#ride_#{@ride4.id}") do
          expect(page).to have_content("Name: #{@ride4.name}")
          expect(page).to have_content("Thrill rating: #{@ride4.thrill_rating}")
        end

        expect(page).to_not have_content("Name: #{@ride2.name}")
        expect(page).to_not have_content("Thrill rating: #{@ride2.thrill_rating}")
      end
    end

    it "shows a form to add an additional ride" do
      visit "/mechanics/#{@mechaninc1.id}"

      within(".add_ride") do
        expect(page).to have_field(:ride_id)
        expect(page).to have_button(:submit)
      end
    end
  end

  describe "when I submit a new ride" do
    it "takes me back to the show page, where the ride is now listed" do
      visit "/mechanics/#{@mechaninc1.id}"

      within(".rides") do
        expect(page).to_not have_content("Name: #{@ride5.name}")
        expect(page).to_not have_content("Thrill rating: #{@ride5.thrill_rating}")
      end

      fill_in :ride_id, with: @ride5.id
      click_button :submit

      expect(current_path).to eq("/mechanics/#{@mechaninc1.id}")

      within(".rides") do
        expect(@ride5.name).to appear_before(@ride4.name)

        within("#ride_#{@ride5.id}") do
          expect(page).to have_content("Name: #{@ride5.name}")
          expect(page).to have_content("Thrill rating: #{@ride5.thrill_rating}")
        end
      end
    end
  end
end
