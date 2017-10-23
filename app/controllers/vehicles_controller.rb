class VehiclesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Vehicle.create(uuid: vehicle_params[:id])
  end

  private

  def vehicle_params
    params.permit(:id)
  end
end
