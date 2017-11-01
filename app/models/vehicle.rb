class Vehicle < ApplicationRecord
  attr_accessor :state

  # Make sure the machine gets initialized so the initial state gets set properly
  def initialize(*)
    super
    machine
  end

  # Replace this with an external source (like a db)
  def transitions
    transitions_data = []
    Transition.all.each do |transition|
      transitions_data << { transition.from.to_sym => transition.to.to_sym, :on => transition.on.to_sym }
    end
    transitions_data
  end

  # Create a state machine for this vehicle instance dynamically based on the
  # transitions defined from the source above
  def machine
    vehicle = self
    @machine ||= Machine.new(vehicle, initial: :designed, action: :save) do
      vehicle.transitions.each {|attrs| transition(attrs)}
    end
  end

  def save
    ap 'save state'
    ap state
    self.write_attribute(:state, state)
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
