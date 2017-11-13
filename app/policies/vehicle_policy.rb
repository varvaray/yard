class VehiclePolicy < ApplicationPolicy

  def index?
    user.present?
  end

  def create?
    false
  end

  def tick?
    user.present?
  end

  def destroy?
    false
  end

end
