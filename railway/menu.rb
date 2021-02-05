# frozen_string_literal: true

# require files

require './train.rb'
require './station.rb'
require './route.rb'
require './passenger_train.rb'
require './cargo_train.rb'
require './wagon.rb'

# methods for interface
class Menu
  def initialize
    @station = nil
    @stations = []
    @train = nil
    @trains = []
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
      end
    end
  end

  private

  def create_station
    puts 'Введите название станции'
    name = gets.chomp
    @station = Station.new(name)
    @stations << @station
  end

  def create_train
    puts 'Введите 1 для пассажирского поезда'
    puts 'Введите 2 для грузового поезда'
    type = gets.chomp.to_i
    puts 'Введите номер поезда'
    number = gets.chomp
    case type
    when 1
      @train = PassengerTrain.new(number)
      @trains << @train
    when 2
      @train = CargoTrain.new(number)
      @trains << @train
    end
  end

  def create_route
    puts 'Введите номер станции из списка для начальной станции'
    print_stations
    number = gets.chomp.to_i
    start = @stations[number - 1]
    puts 'Введите номер станции из списка для конечной станции'
    print_stations
    number = gets.chomp.to_i
    finish = @stations[number - 1]
    @route = Route.new(start, finish)
    @routs << @route
  end

  def create_wagon
    puts 'Введите 1 для пассажирского вагона и 2 для грузового вагона'
    case gets.chomp.to_i
    when 1
      type = :passenger
    when 2
      type = :cargo
    end
    puts 'Введите номер вагона'
    number = gets.chomp
    @wagon = Wagon.new(number, type)
    @wagons << @wagon
  end

  def assign_route
    @train.train_route(@route)
  end

  def route_change
    puts 'Введите 1 для того чтобы добавить станцию в маршрут'
    puts 'Введите 2 для того чтобы удалить станцию из маршрута'
    case gets.chomp.to_i
    when 1
      add_station_to_route
    when 2
      del_station_from_route
    end
  end

  def add_station_to_route
    puts 'Введите номер станции из списка для начальной станции'
    print_stations
    number = gets.chomp.to_i
    station_name = @stations[number - 1]
    puts 'Введите номер станции, на которую ее добавить'
    number = gets.chomp.to_i
    @route.add_station(station_name, number)
  end

  def del_station_from_route
    puts 'Введите номер станции из списка для начальной станции'
    print_stations
    number = gets.chomp.to_i
    station_name = @stations[number - 1]
    @route.delete_station(station_name)
  end

  def train_change
    puts 'Введите 1 для того чтобы прицепить выбранный вагон к выбранному поезду'
    puts 'Введите 2 для того чтобы отцепить выбранный вагон'
    case gets.chomp.to_i
    when 1
      @train.add_wagon(@wagon)
    when 2
      @train.delete_wagon(@wagon)
    end
  end

  def moving_train
    puts 'Введите 1, чтобы передвинуть выбранный поезд на следующую станцию'
    puts 'Введите 2, чтобы передвинуть выбранный поезд на предыдущую станцию'
    case gets.chomp.to_i
    when 1
      @train.moving_forward
    when 2
      @train.moving_back
    end
  end

  def select_station
    puts 'Введите номер станции из списка, которую хотите выбрать'
    print_stations
    @station = @stations[gets.chomp.to_i - 1]
  end

  def select_train
    puts 'Введите номер поезда из списка, который хотите выбрать'
    print_trains
    @train = @trains[gets.chomp.to_i - 1]
  end

  def select_route
    puts 'Введите номер маршрута из списка, который хотите выбрать'
    puts @routs.inspect
    @route = @routs[gets.chomp.to_i - 1]
  end

  def select_wagon
    puts 'Введите номер вагона из списка, который хотите выбрать'
    puts @wagons.inspect
    @wagon = @wagons[gets.chomp.to_i - 1]
  end

  def print_stations
    @stations.each.with_index(1) { |station, i| puts "#{i} #{station.name}" }
  end

  def print_trains(trains = @trains)
    trains.each { |train| puts train.number }
  end

  def list_of_train
    puts 'На станции сейчас следующие поезда'
    @stations.each do |station|
      print_trains(station.trains)
    end
  end

  def print_actions
    puts "Сейчас выбран поезд #{@train.number}" if @train
    puts "Сейчас выбран маршрут #{@route.stations}" if @route
    puts "Сейчас выбран вагон #{@wagon.number}" if @wagon
    puts 'Введите 0, для выхода'

    puts 'Введите 1, если хотите создать станцию'
    puts 'Введите 2, если хотите создать поезд'
    puts 'Введите 3, если хотите создать маршрут'
    puts 'Введите 4, если хотите создать вагон'

    puts 'Введите 5, если хотите назначить выбранный маршрут выбранному поезду'
    puts 'Введите 6, если хотите добавить или удалить станцию'
    puts 'Введите 7, если хотите прицепить или отцепить вагон к поезду'
    puts 'Введите 8, если хотите передвинуть поезд'

    puts 'Введите 9, чтобы сменить выбранный станцию'
    puts 'Введите 10, чтобы сменить выбранный поезд'
    puts 'Введите 11, чтобы сменить выбранный маршрут'
    puts 'Введите 12, чтобы сменить выбранный вагон'

    puts 'Введите 13, чтобы посмотреть все станции'
    puts 'Введите 14, чтобы посмотеть поезда на выбранной станции'
    puts 'Выберите вариант: '
  end
end
# testing data
#   puts $station.inspect
#   puts $stations.inspect
#   puts $train.inspect
#   puts $trains.inspect
#   puts $route.inspect
#   puts $routs.inspect
#   puts $wagon.inspect
#   puts $wagons.inspect
#
#
#
# station1 = Station.new('station1')
# station2 = Station.new('station2')
# station3 = Station.new('station3')
#
# route1 = Route.new(station1, station2)
# route1.add_station(station3, 1)
#
# train = CargoTrain.new('train')
# train1 = PassengerTrain.new('train1')
# train2 = PassengerTrain.new('train2')
# train3 = CargoTrain.new('train3')
#
# cargo_wagon1 = Wagon.new('1', :cargo)
# cargo_wagon2 = Wagon.new('2', :cargo)
# passenger_wagon1 = Wagon.new('3', :passenger)
# passenger_wagon2 = Wagon.new('4', :passenger)
#
#
# train1.train_route(route1)
# train2.train_route(route1)
# train3.train_route(route1)
#
# train2.moving_forward
# train1.moving_forward
# train1.moving_forward
# train1.moving_forward
# train1.moving_back
# train1.moving_back
# train1.moving_back
#
# train.speed
#
# train.stop
# train.speed = 10
# train.add_wagon(cargo_wagon1)
# train.add_wagon(passenger_wagon2)
# train.delete_wagon(cargo_wagon1)
#
# train.stop
# train.add_wagon(cargo_wagon1)
# train.add_wagon(cargo_wagon1)
# train3.add_wagon(cargo_wagon1)
# train.delete_wagon(cargo_wagon1)
#
#
# train.add_wagon(passenger_wagon2)
# train1.add_wagon(passenger_wagon2)
# train.add_wagon(cargo_wagon1)
#
#
