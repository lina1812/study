# frozen_string_literal: true

# Menu methods that relate to select object (station, train, route or wagon)

class Menu
  module SelectObject
    private

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
  end
end
