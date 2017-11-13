class VehicleState < ApplicationRecord
  validate :not_duplicated, on: :create

  private

  def not_duplicated
    all = self.class.all.pluck(:order)
    errors.add(:order, I18n.t('errors.duplicated_order')) if all.include?(self.order)
  end

end