# frozen_string_literal: true

require './instance_counter.rb'
require './validatable.rb'

# All route logic
class Route
  attr_accessor :stations
  include InstanceCounter
  include Validatable

  def initialize(start, finish)
    @stations = [start, finish]
    register_instance
    validate!
  end

  def add_station(station, place)
    if @stations.include?(station)
      raise 'Такая станция уже есть в маршруте'
    elsif place != 0 && place < @stations.size
      @stations.insert(place, station)
    else
      raise 'Нельзя добавить станцию на эту позицию'
    end
  end

  def delete_station(station)
    if [@stations.first, @stations.last].include?(station)
      raise 'Нельзя удалить начальную или конечную станцию'
    elsif @stations.include?(station)
      @stations.delete(station)
    else
      raise 'Такой станции нет в марштуре'
    end
  end

  def next_station(current_station)
    if current_station != @stations.last && @stations.include?(current_station)
      @stations[@stations.index(current_station) + 1]
    end
  end

  def previous_station(current_station)
    if current_station != @stations.first && @stations.include?(current_station)
      @stations[@stations.index(current_station) - 1]
    end
  end

  private

  def validate!
    raise 'Start station should be a Station' unless @stations.first.is_a?(Station)
    raise 'Finish station should be a Station' unless @stations.last.is_a?(Station)
  end
end
