class RideMechanicsController < ApplicationController
  def create
    @ride = Ride.find(params[:ride_id])
    @mechanic = Mechanic.find(params[:id])
    RideMechanic.create!(ride: @ride, mechanic: @mechanic)

    redirect_to "/mechanics/#{params[:id]}"
  end
end
