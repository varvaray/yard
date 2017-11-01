class VehiclePolicy < ApplicationPolicy

  def index?
    true if user.present?
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
