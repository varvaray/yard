class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vehicle, only: %i(show tick)

  def index
    authorize Vehicle
    @vehicles = policy_scope Vehicle.all
    render json: {
      user: current_user,
      vehicles: @vehicles
    }
  end

  def show
    render json: { vehicle: @vehicle }
  end

  def tick
    @vehicle.machine.request
    render json: { vehicle: @vehicle }
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
    authorize @vehicle
  end
end