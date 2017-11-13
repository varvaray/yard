class Vehicle < ApplicationRecord
  attr_accessor :state
  has_one :vehicle_state, foreign_key: :id

  def initialize(*)
    super
    machine
  end

  def transitions
    # ap 'transitions'
    transitions_data = []
    states = VehicleState.all.order(order: :asc)
    from = states.first.order
    states.each do |state|
      next if state.order == from
      to = state.order
      transitions_data << { from => to, on: :request }
      from = state.order
    end
    transitions_data << { from => states.first.order, on: :request }
    # ap 'transitions data = '
    # ap transitions_data
    transitions_data
  end

  def machine
    vehicle = self
    @machine ||= Machine.new(vehicle, initial: 1, action: :save) do
      vehicle.transitions.each {|attrs| transition(attrs)}
    end
  end

  def save
    # ap 'save state'
    # ap vehicle_state_id
    # ap state
    self.write_attribute(:vehicle_state_id, state)
  end
end


class Machine
  def self.new(object, *args, &block)
    machine_class = Class.new
    machine = machine_class.state_machine(*args, &block)
    attribute = machine.attribute
    action = machine.action

    machine_class.class_eval do
      define_method(:definition) { machine }
      define_method(attribute) { object.send(attribute) }
      define_method("#{attribute}=") {|value| object.send("#{attribute}=", value) }
      define_method(action) { object.send(action) } if action
    end

    machine_class.new
  end
end
