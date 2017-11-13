FactoryBot.define do
  LIST = %w(designed assembled painted tested)

  factory :vehicle do

    sequence(:vehicle_state_id) { 1 }
    sequence(:name) { Faker::StarWars.vehicle }

    after :create, &:save
  end
end