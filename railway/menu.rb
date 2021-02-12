# frozen_string_literal: true

# require files

require './station.rb'
require './route.rb'

require './train.rb'
require './passenger_train.rb'
require './cargo_train.rb'

require './wagon.rb'
require './passenger_wagon.rb'
require './cargo_wagon.rb'

require './menu/create_object.rb'
require './menu/select_object.rb'

require './menu/change_route.rb'
require './menu/change_train.rb'
require './menu/change_wagon.rb'

require './menu/print.rb'

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

  include CreateObject
  include SelectObject
  include ChangeRoute
  include ChangeTrain
  include ChangeWagon
  include Print

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
