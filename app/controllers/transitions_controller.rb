class TransitionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transition, only: %i(show update destroy)

  def index
    render json: { transitions: Transition.all }
  end

  def show
    render json: { transition: @transition }
  end

  def update
    if @transition.update transition_params
      render json: { transition: @transition }
    else
      render json: { errors: @transition.errors }
    end
  end

  private

  def transition_params
    params.permit(:id, :from, :to, :on)
  end

  def set_transition
    @transition = Transition.find(params[:id])
    authorize @transition
  end
end