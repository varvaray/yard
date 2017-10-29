class VehiclePolicy < ApplicationPolicy
  attr_reader :user, :vehicle

  def initialize(user, vehicle)
    @user = user
    @vehicle = vehicle
  end

  def index?
    true
  end

  def create?
    false
  end

  def update?
    true if user.present?
  end

  def destroy?
    false
  end

end
