class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vehicle, only: %i(show update)

  def index
    render json: {
      message: "Welcome #{current_user.email}",
      user: current_user,
      vehicles: Vehicle.all
    }
  end

  def show
    render json: { vehicle: @vehicle }
  end

  def update
    @vehicle.update vehicle_params
  end

  private

  def vehicle_params
    params.permit(:id, :state, :name)
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
    authorize @vehicle
  end
end