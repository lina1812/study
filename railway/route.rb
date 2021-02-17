# frozen_string_literal: true

require './instance_counter.rb'
require './accessors.rb'

# All route logic
class Route
  attr_accessor :stations
  include InstanceCounter
  extend Accessors

  attr_accessor_with_history :name, :name2
  strong_attr_accessor :arg1, Symbol

  def initialize(start, finish)
    @stations = [start, finish]
    register_instance
    validate!
  end

  def add_station(station, place)
    raise 'Such a station is already on the route' if @stations.include?(station)
    raise "Can't add a station to this position" if place == 0 || place >= @stations.size

    @stations.insert(place, station)
  end

  def delete_station(station)
    raise 'Start or Finish Station cannot be deleted' if [@stations.first, @stations.last].include?(station)
    raise 'There is no such station on the route' unless @stations.include?(station)

    @stations.delete(station)
  end

  def next_station(current_station)
    return unless current_station != @stations.last && @stations.include?(current_station)

    @stations[@stations.index(current_station) + 1]
  end

  def previous_station(current_station)
    return unless current_station != @stations.first && @stations.include?(current_station)

    @stations[@stations.index(current_station) - 1]
  end

  private

  def validate!
    raise 'Start station should be a Station' unless @stations.first.is_a?(Station)
    raise 'Finish station should be a Station' unless @stations.last.is_a?(Station)
  end
end
