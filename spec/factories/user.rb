FactoryBot.define do
  factory :user do
    transient do
      first_time false
      expired_password false
    end

    sequence(:uid) { Faker::StarWars.character }
    sequence(:email) { Faker::Internet.safe_email(uid) }
    sequence(:name) { Faker::Name.first_name + ' ' +Faker::Name.last_name }
    created_at { DateTime.now }
    password { SecureRandom.hex(8) }
    password_confirmation { password }

  end
end