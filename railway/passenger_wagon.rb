# frozen_string_literal: true

# Passenger wagon description

class PassengerWagon < Wagon
  attr_accessor :seats, :occupied_seats, :free_seats

  def initialize(number, seats)
    super
    @seats = seats
    @free_seats = seats
    @occupied_seats = 0
  end

  def take_a_seat
    return unless @occupied_seats < seats

    @occupied_seats += 1
    @free_seats = - 1
  end

  def free_up_a_seat
    return unless @occupied_seats > 0

    @occupied_seats -= 1
    @free_seats += 1
  end

  def print_wagon
    super
    puts "Wagon's free seats: #{@free_seats}"
    puts "Wagon's occupied seats: #{@occupied_seats}"
  end

  def initial_type
    :passenger
  end
end
