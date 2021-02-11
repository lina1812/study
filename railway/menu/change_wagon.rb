# frozen_string_literal: true

# Menu methods that relate to changing the wagon

class Menu
  module ChangeWagon
    private

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
        @wagon.free_up_a_seat
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
  end
end
