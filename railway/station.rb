# frozen_string_literal: true

require './instance_counter.rb'
require './validatable.rb'

# All station logic
class Station
  include InstanceCounter
  include Validatable

  attr_reader :trains, :name

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def take_a_train(train)
    if @trains.include?(train)
      raise 'This train is already at the station'
    else
      @trains << train
    end
  end

  def send_a_train(train)
    if @trains.include?(train)
      @trains.delete(train)
    else
      raise "This train isn't at the station"
    end
  end

  def self.all
    @@stations
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }.count
  end

  private

  def validate!
    raise "Station's name can't be nil" if name.nil?
    raise "Station's name should be at least 2 symbols" if name.length < 2
  end
end
