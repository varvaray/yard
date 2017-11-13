# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'varvara.ratnikova@gmail.com', role: 1, password: 'testmyapp', provider: 'email')
User.create(email: 'test.account@gmail.com', role: 0, password: 'testmyapp2', uid: 'regular')

# Transition.create(from: :designed, to: :assembled)
# Transition.create(from: :assembled, to: :painted)
# Transition.create(from: :painted, to: :tested)
# Transition.create(from: :tested, to: :designed)

VehicleState.find_or_create_by(name: :designed, order: 1)
VehicleState.find_or_create_by(name: :assembled, order: 2)
VehicleState.find_or_create_by(name: :painted, order: 3)
VehicleState.find_or_create_by(name: :tested, order: 4)

test = Vehicle.find_or_create_by!(vehicle_state_id: 1, name: 'subaru')
ap 'create vehicle'
# ap test
# test.save!
Vehicle.find_or_create_by!(vehicle_state_id: 2, name: 'opel')