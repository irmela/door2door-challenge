class VehiclesController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_vehicle

  def create
    if @vehicle
      @vehicle.update(moving: true)
    else
      @vehicle = Vehicle.create(uuid: vehicle_params[:id], moving: true)
    end
  end

  def destroy
    @vehicle.update(moving: false) if @vehicle
  end

  private

  def vehicle_params
    params.permit(:id)
  end

  def set_vehicle
    @vehicle = Vehicle.where(uuid: vehicle_params[:id]).first
  end
end
