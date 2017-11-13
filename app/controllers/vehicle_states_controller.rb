class VehicleStatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vehicle_state, only: %i(show update destroy)

  def index
    authorize VehicleState
    render json: {
        user: current_user,
        states: policy_scope(VehicleState.all)
    }
  end

  def show
    render json: { vehicle: @state }
  end

  def new
    @state = VehicleState.new
    authorize @state
    render json: { state: @state }
  end

  def create
    @state = VehicleState.new(vehicle_states_params)
    authorize @state
    @state.save
    if @state.errors.any?
      render json: { errors: [message: @state.errors.messages] }, status: 409
    else
      render json: { state: @state }
    end
  end

  def destroy
    @state.destroy
    if @state.errors.any?
      render json: { errors: @state.errors }
    else
      render json: { states: VehicleState.all }
    end
  end

  def update
    errors = VehicleState.connection.transaction do
      replace_state = VehicleState.find_by(order: vehicle_states_params['order'])
      replace_state.update order: @state.order
      @state.update vehicle_states_params
      @state.errors.full_messages + replace_state.errors.full_messages
    end.flatten

    if errors.any?
      render json: { errors: errors }, status: 409
    else
      render json: { states: VehicleState.all }
    end
  end

  private

  def vehicle_states_params
    params.permit(:id, :order, :name)
  end

  def set_vehicle_state
    @state = VehicleState.find(params[:id])
    authorize @state
  end
end