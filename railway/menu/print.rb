# frozen_string_literal: true

# Menu methods that relate to print

class Menu
  module Print
    private

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
end
