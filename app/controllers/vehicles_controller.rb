class VehiclesController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :parse_request_params, only: :create
  before_action :set_vehicle

  def create
    if @vehicle
      @vehicle.update_column(:moving, true)
    else
      @vehicle = Vehicle.create(uuid: vehicle_params[:id], moving: true)
    end
  end

  private

  def vehicle_params
    params.permit(:id)
  end

  def set_vehicle
    @vehicle = Vehicle.where(uuid: vehicle_params[:id]).first
  end
end
