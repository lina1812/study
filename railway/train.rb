# frozen_string_literal: true

require './manufacturer.rb'
require './instance_counter.rb'

# All train logic
class Train
  include Manufacturer
  include InstanceCounter

  attr_accessor :speed
  attr_reader :route, :current_station, :type, :number, :wagons

  @@trains = []

  def initialize(number)
    @number = number
    @type = initial_type
    @wagons = []
    @speed = 0
    @@trains << self
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    if @speed != 0
      puts 'Поезд движется'
    elsif wagon.train == self
      puts 'Вагон уже прицеплен к этому поезду'
    elsif !wagon.train.nil?
      puts 'Вагон прицеплен к другому поезду'
    elsif wagon.type == type
      @wagons << wagon
      wagon.train = self
      puts 'Вагон прицеплен'
    else
      puts 'У вагона и поезда не совпадают типы'
    end
  end

  def delete_wagon(wagon)
    if @speed != 0
      puts 'Поезд движется'
    elsif @wagons.include?(wagon)
      @wagons.delete(wagon)
      wagon.train = nil
      puts 'Вагон отцеплен'
    else
      puts 'Такого вагона нет в поезде'
    end
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
    route_next = @route.next_station(current_station)
    route_next || puts('Поезд на конечной станции')
  end

  def previous_station
    route_previous = @route.previous_station(current_station)
    route_previous || puts('Поезд на начальной станции')
  end

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def self.all
    @@trains
  end

  def print
    puts "Номер поезда: #{number}"
    puts "Тип поезда: #{type}"
    puts "Маршрут поезда: #{route}" if @route
    puts "Вагоны поезда: #{wagons.map { |wagon| wagon.number }}" if @wagons
  end

  private

  # метод moving_to используется для перемещения вагона на определенную станцию
  # так как мы не можем перепрыгивать через станции я убрала его в private
  def moving_to(station)
    puts station
    @current_station&.send_a_train(self)
    @current_station = station
    @current_station.take_a_train(self)
    true
  end
end
