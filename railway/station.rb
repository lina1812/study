# frozen_string_literal: true

require './instance_counter.rb'

# All station logic
class Station
  include InstanceCounter

  attr_reader :trains, :name

  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def take_a_train(train)
    if @trains.include?(train)
      puts 'Этот поезд уже на станции'
    else
      @trains << train
    end
  end

  def send_a_train(train)
    if @trains.include?(train)
      @trains.delete(train)
    else
      puts 'Этого поезда нет на станции'
    end
  end

  def self.all
    @@stations
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }.count
  end
end
