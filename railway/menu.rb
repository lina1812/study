# frozen_string_literal: true

# require files

require './train.rb'
require './station.rb'
require './route.rb'
require './passenger_train.rb'
require './cargo_train.rb'
require './wagon.rb'
require './passenger_wagon.rb'
require './cargo_wagon.rb'

# methods for interface

class Menu
  def initialize
    @station = nil
    @train = nil
    @route = nil
    @routs = []
    @wagon = nil
    @wagons = []
  end

  def main_loop
    loop do
      print_actions
      case gets.chomp.to_i
      when 0
        break
      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      when 4
        create_wagon
      when 5
        assign_route
      when 6
        route_change
      when 7
        train_change
      when 8
        moving_train
      when 9
        select_station
      when 10
        select_train
      when 11
        select_route
      when 12
        select_wagon
      when 13
        print_stations
      when 14
        list_of_train
      when 15
        list_of_wagon
      when 16
        wagon_change
      end
    end
  end

  private

  def create_station
    puts 'Enter station name'
    name = gets.chomp
    @station = Station.new(name)
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_train
    puts 'Enter 1 for passenger train'
    puts 'Enter 2 for cargo train'
    type = gets.chomp.to_i
    begin
      puts 'Enter train number'
      number = gets.chomp
      case type
      when 1
        @train = PassengerTrain.new(number)
      when 2
        @train = CargoTrain.new(number)
      end
      puts "Train number #{@train.number} ant type #{@train.type} was created"
    rescue StandardError => e
      puts e.message
      retry
    end
  end

  def create_route
    puts 'Enter the station number from the list for the starting station'
    print_stations
    number = gets.chomp.to_i
    start = Station.all[number - 1]
    puts 'Enter the station number from the list for the end station'
    print_stations
    number = gets.chomp.to_i
    finish = Station.all[number - 1]
    @route = Route.new(start, finish)
    @routs << @route
  rescue StandardError => e
    puts e.message
  end

  def create_wagon
    puts 'Enter 1 for a passenger wagon and 2 for a cargo wagon'
    case gets.chomp.to_i
    when 1
      create_passenger_wagon
    when 2
      create_cargo_wagon
    end
    @wagons << @wagon
  rescue StandardError => e
    puts e.message
  end

  def create_passenger_wagon
    puts "Enter wagon's number"
    number = gets.chomp
    puts 'Enter count of seats'
    seats = gets.chomp.to_i
    @wagon = PassengerWagon.new(number, seats)
  end

  def create_cargo_wagon
    puts "Enter wagon's number"
    number = gets.chomp
    puts 'Enter volume'
    volume = gets.chomp.to_i
    @wagon = CargoWagon.new(number, volume)
  end

  def assign_route
    @train.train_route(@route)
  end

  def route_change
    puts 'Enter 1 to add a station to the route'
    puts 'Enter 2 to remove a station from the route'
    case gets.chomp.to_i
    when 1
      add_station_to_route
    when 2
      del_station_from_route
    end
  rescue StandardError => e
    puts e.message
  end

  def add_station_to_route
    puts 'Enter the station number from the list for the new station'
    print_stations
    number = gets.chomp.to_i
    station_name = Station.all[number - 1]
    puts 'Enter station position number to add it'
    number = gets.chomp.to_i
    @route.add_station(station_name, number)
  end

  def del_station_from_route
    puts 'Enter the station number from the list for the station to be deleted'
    print_stations
    number = gets.chomp.to_i
    station_name = Station.all[number - 1]
    @route.delete_station(station_name)
  end

  def train_change
    puts 'Enter 1 to attach the selected wagon to the selected train'
    puts 'Enter 2 to unhook the selected wagon'
    case gets.chomp.to_i
    when 1
      @train.add_wagon(@wagon)
    when 2
      @train.delete_wagon(@wagon)
    end
  rescue StandardError => e
    puts e.message
  end

  def moving_train
    puts 'Enter 1 to move the selected train to the next station'
    puts 'Enter 2 to move the selected train to the previous station'
    case gets.chomp.to_i
    when 1
      @train.moving_forward
    when 2
      @train.moving_back
    end
  rescue StandardError => e
    puts e.message
  end

  def select_station
    puts 'Enter a station number from the list to select it'
    print_stations
    @station = Station.all[gets.chomp.to_i - 1]
  end

  def select_train
    puts 'Enter a train number from the list to select it'
    print_trains
    @train = Train.all[gets.chomp.to_i - 1]
  end

  def select_route
    puts 'Enter a route number from the list to select it'
    puts @routs.inspect
    @route = @routs[gets.chomp.to_i - 1]
  end

  def select_wagon
    puts 'Enter a wagon number from the list to select it'
    puts @wagons.inspect
    @wagon = @wagons[gets.chomp.to_i - 1]
  end

  def print_stations
    Station.all.each.with_index(1) { |station, i| puts "#{i} #{station.name}" }
  end

  def print_trains(trains = Train.all)
    trains.each { |train| puts train.number }
  end

  def list_of_train
    puts 'There are trains at the station now'
    Station.all.each do |station|
      # print_trains(station.trains)
      station.each_train { |train| train.print }
    end
  end

  def list_of_wagon
    @train.each_wagon { |wagon| wagon.print_wagon }
  end

  def wagon_change
    if @wagon.type == :passenger
      change_passenger_wagon
    else
      change_cargo_wagon
    end
  end

  def change_passenger_wagon
    puts 'Enter 1 to take a seat'
    puts 'Enter 2 to free up seat'
    case gets.chomp.to_i
    when 1
      @wagon.take_a_seat
    when 2
      @wagon.free_up_seat
    end
  end

  def change_cargo_wagon
    puts 'Enter 1 to take a volume'
    puts 'Enter 2 to free up volume'
    case gets.chomp.to_i
    when 1
      take_volume
    when 2
      free_up_volume
    end
  end

  def take_volume
    puts 'Enter volume'
    volume = gets.chomp.to_i
    @wagon.take_a_volume(volume)
  end

  def free_up_volume
    puts 'Enter volume'
    volume = gets.chomp.to_i
    @wagon.free_up_a_volume(volume)
  end

  def print_actions
    puts "Now selected train #{@train.number}" if @train
    puts "Now selected route #{@route.stations}" if @route
    puts "Now selected wagon #{@wagon.number}" if @wagon
    puts 'Enter 0 to exit'

    puts 'Enter 1 to create a station'
    puts 'Enter 2 to create a train'
    puts 'Enter 3 to create a route'
    puts 'Enter 4 to create a wagon'

    puts 'Enter 5 to assign the selected route to the selected train'
    puts 'Enter 6 to add or remove a station'
    puts 'Enter 7 to attach or unhitch the wagon to the train'
    puts 'Enter 8 to move the train'

    puts 'Enter 9 to change the selected station'
    puts 'Enter 10 to change the selected train'
    puts 'Enter 11 to change the selected route'
    puts 'Enter 12 to change the selected wagon'

    puts 'Enter 13 to print all stations'
    puts 'Enter 14 to print trains at the selected station'
    puts 'Enter 15 to print a list of wagons for the selected train'
    puts 'Enter 16 to changing the wagon'
    puts 'Choose number: '
  end
end

# testing data
#  puts $station.inspect
#  puts $stations.inspect
#  puts $train.inspect
#  puts $trains.inspect
#  puts $route.inspect
#  puts $routs.inspect
#  puts $wagon.inspect
#  puts $wagons.inspect

#  station1 = Station.new('station1')
#  station2 = Station.new('station2')
#  station3 = Station.new('station3')
#
#  route1 = Route.new(station1, station2)
#  route1.add_station(station3, 1)
#
#  train = CargoTrain.new('train')
#  train1 = PassengerTrain.new('train1')
#  train2 = PassengerTrain.new('train2')
#  train3 = CargoTrain.new('train3')
#
#  cargo_wagon1 = Wagon.new('1', :cargo)
#  cargo_wagon2 = Wagon.new('2', :cargo)
#  passenger_wagon1 = Wagon.new('3', :passenger)
#  passenger_wagon2 = Wagon.new('4', :passenger)
#
#
#  train1.train_route(route1)
#  train2.train_route(route1)
#  train3.train_route(route1)
#
#  train2.moving_forward
#  train1.moving_forward
#  train1.moving_forward
#  train1.moving_forward
#  train1.moving_back
#  train1.moving_back
#  train1.moving_back
#
#  train.speed
#
#  train.stop
#  train.speed = 10
#  train.add_wagon(cargo_wagon1)
#  train.add_wagon(passenger_wagon2)
#  train.delete_wagon(cargo_wagon1)
#
#  train.stop
#  train.add_wagon(cargo_wagon1)
#  train.add_wagon(cargo_wagon1)
#  train3.add_wagon(cargo_wagon1)
#  train.delete_wagon(cargo_wagon1)
#
#
#  train.add_wagon(passenger_wagon2)
#  train1.add_wagon(passenger_wagon2)
#  train.add_wagon(cargo_wagon1)
#
#  train.manufacturer = 'volvo'
#
#  puts train.manufacturer
#
#  puts Train.find('train')
#
#  puts CargoTrain.instances
#
#  Station.all
