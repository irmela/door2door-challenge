class VehiclesController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_vehicle

  def index
    @vehicles = Vehicle.includes(:locations).where(moving: true)
    render json: @vehicles,
           include: { locations: { except: %i[created_at updated_at] } },
           except: %i[created_at updated_at],
           status: :ok
  end

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
