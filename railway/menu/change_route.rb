# frozen_string_literal: true

# Menu methods that relate to changing the route

class Menu
  module ChangeRoute
    private

    def assign_route
      puts @train
      puts @route
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
  end
end
