# frozen_string_literal: true

require './manufacturer.rb'
require './instance_counter.rb'
require './validation.rb'

# All train logic
class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_accessor :speed
  attr_reader :route, :current_station, :type, :number, :wagons
  VALID_NUMBER = /^[a-z1-9]{3}-?[a-z1-9]{2}$/i.freeze

  validate :number, :presence
  validate :number, :format, VALID_NUMBER
  validate :type, :presence

  # rubocop:disable Style/ClassVars
  @@trains = []
  # rubocop:enable Style/ClassVars

  def initialize(number)
    @number = number
    @type = initial_type
    @wagons = []
    @speed = 0
    @@trains << self
    validate!
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    raise 'The train is moving' if @speed != 0
    raise 'The wagon is already attached to this train' if wagon.train == self
    raise 'The wagon is hitched to another train' unless wagon.train.nil?
    raise 'The type of the wagon and the train does not match' if wagon.type != type

    @wagons << wagon
    wagon.train = self
    true
  end

  def delete_wagon(wagon)
    raise 'The train is moving' if @speed != 0
    raise 'There is no such carriage on the train' unless @wagons.include?(wagon)

    @wagons.delete(wagon)
    wagon.train = nil
    true
  end

  def train_route(route)
    @route = route
    moving_to(@route.stations.first)
  end

  def moving_forward
    return false unless next_station

    moving_to(next_station)
  end

  def moving_back
    return false unless previous_station

    moving_to(previous_station)
  end

  def next_station
    @route.next_station(current_station)
  end

  def previous_station
    @route.previous_station(current_station)
  end

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def self.all
    @@trains
  end

  def print
    puts "Train number: #{number}"
    puts "Train type: #{type}"
    # puts "Маршрут поезда: #{route}" if @route
    puts "Train wagons: #{wagons.count}" if @wagons
  end

  def each_wagon
    @wagons.each do |wagon|
      yield(wagon)
    end
  end

  private

  # метод moving_to используется для перемещения вагона на определенную станцию
  # так как мы не можем перепрыгивать через станции я убрала его в private
  def moving_to(station)
    @current_station&.send_a_train(self)
    @current_station = station
    @current_station.take_a_train(self)
    true
  end

  #  def validate!
  #    raise "Train number can't be nil" unless number
  #    raise 'Number has invalid format' if number !~ VALID_NUMBER
  #    raise "Train type can't be nil" if type.nil?
  #  end
end
