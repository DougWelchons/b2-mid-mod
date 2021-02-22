class Mechanic < ApplicationRecord
  has_many :ride_mechanics
  has_many :rides, through: :ride_mechanics

  def self.average_experience
    average(:years_experience)
  end

  def sorted_open_rides
    rides.where(open: true).order(thrill_rating: :desc)
  end
end
