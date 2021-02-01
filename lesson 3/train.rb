# frozen_string_literal: true

# All train logic
class Train
  attr_accessor :speed
  attr_reader :number_of_wagons, :route, :current_station, :type

  def initialize(number, type, number_of_wagons)
    @number = number
    @type = type
    @number_of_wagons = number_of_wagons
  end

  def stop
    @speed = 0
  end

  def add_wagon
    if @speed == 0
      @number_of_wagons += 1
    else
      puts 'Поезд движется'
    end
  end

  def delete_wagon
    if @speed == 0
      @number_of_wagons -= 1 if @number_of_wagons > 1
    else
      puts 'Поезд движется'
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

  private

  def moving_to(station)
    @current_station&.send_a_train(self)
    @current_station = station
    @current_station.take_a_train(self)
    true
  end
end
