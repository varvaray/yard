FactoryBot.define do

  factory :vehicle_state do

    sequence(:order) { order }
    sequence(:name) { Faker::StarWars.droid }

  end
end