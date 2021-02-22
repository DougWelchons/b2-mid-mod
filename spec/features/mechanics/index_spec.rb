require 'rails_helper'

RSpec.describe "Mechanic index page" do
  before :each do
    @mechaninc1 = Mechanic.create!(name: "Mechaninc1", years_experience: 1)
    @mechaninc2 = Mechanic.create!(name: "Mechaninc2", years_experience: 2)
    @mechaninc3 = Mechanic.create!(name: "Mechaninc3", years_experience: 3)
  end

  describe "when I visit the mechanic index page" do
    it "shows a headder 'all Mechanics'" do
      visit "/mechanics"

      expect(page).to have_content("All Mechanics")
    end

    it "it list all mechanics and their yeears of experiance" do
      visit "/mechanics"

      within(".mechanics") do
        within("#mechaninc_#{@mechaninc1.id}") do
          expect(page).to have_content("Name: Mechaninc1")
          expect(page).to have_content("Years of Experience: 1")
        end

        within("#mechaninc_#{@mechaninc2.id}") do
          expect(page).to have_content("Name: Mechaninc2")
          expect(page).to have_content("Years of Experience: 2")
        end

        within("#mechaninc_#{@mechaninc3.id}") do
          expect(page).to have_content("Name: Mechaninc3")
          expect(page).to have_content("Years of Experience: 3")
        end
      end
    end

    it "it shows the average years of experiance for all mechanics" do
      visit "/mechanics"

      expect(page).to have_content("average years of experience: 2")
    end
  end
end
