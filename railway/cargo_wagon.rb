# frozen_string_literal: true

# Cargo wagon description

class CargoWagon < Wagon
  attr_accessor :volume, :occupied_volume, :free_volume

  def initialize(number, volume)
    super
    @volume = volume
    @free_volume = volume
    @occupied_volume = 0
  end

  def take_a_volume(volume)
    @occupied_volume += volume if volume <= @free_volume
    @free_volume -= volume
  end

  def free_up_a_volume(volume)
    return unless @occupied_volume > volume

    @occupied_volume -= volume
    @free_volume += volume
  end

  def print_wagon
    super
    puts "Wagon's free volume: #{@free_volume}"
    puts "Wagon's occupied volume: #{@occupied_volume}"
  end

  def initial_type
    :cargo
  end
end
