class LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Location.create(location_params.merge(vehicle: find_vehicle))
  end

  private

  def location_params
    params.require(:location).permit(:lat, :lng, :at)
  end

  def find_vehicle
    Vehicle.where(uuid: params[:vehicle_id]).first
  end
end
