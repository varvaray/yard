class Vehicle < ApplicationRecord
  attr_accessor :state

  # Make sure the machine gets initialized so the initial state gets set properly
  def initialize(*)
    super
    machine
  end

  # Replace this with an external source (like a db)
  def transitions
    [
        {parked: :idling, on: :ignite},
        {idling: :first_gear, first_gear: :second_gear, on: :shift_up}
    # ...
    ]
  end

  # Create a state machine for this vehicle instance dynamically based on the
  # transitions defined from the source above
  def machine
    vehicle = self
    @machine ||= Machine.new(vehicle, initial: :parked, action: :save) do
      vehicle.transitions.each {|attrs| transition(attrs)}
    end
  end

  def save
    # Save the state change...
    true
  end
end

# Generic class for building machines
class Machine
  def self.new(object, *args, &block)
    machine_class = Class.new
    machine = machine_class.state_machine(*args, &block)
    attribute = machine.attribute
    action = machine.action

    # Delegate attributes
    machine_class.class_eval do
      define_method(:definition) { machine }
      define_method(attribute) { object.send(attribute) }
      define_method("#{attribute}=") {|value| object.send("#{attribute}=", value) }
      define_method(action) { object.send(action) } if action
    end

    machine_class.new
  end
end
