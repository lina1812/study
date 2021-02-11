# frozen_string_literal: true

# Menu methods that relate to create object (station, train, route or wagon)

class Menu
  module CreateObject
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
  end
end
