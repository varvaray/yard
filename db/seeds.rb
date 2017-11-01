# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Vehicle.create(state: 0, name: 'subaru')
Vehicle.create(state: 1, name: 'opel')

User.create(email: 'varvara.ratnikova@gmail.com', role: 1, password: 'testmyapp', provider: 'email')
User.create(email: 'test.account@gmail.com', role: 0, password: 'testmyapp2', uid: 'regular')

Transition.create(from: :designed, to: :assembled, on: :click)
Transition.create(from: :assembled, to: :painted, on: :click)
Transition.create(from: :painted, to: :tested, on: :click)