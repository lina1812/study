# frozen_string_literal: true

# All route logic
class Route
  attr_accessor :stations
  include InstanceCounter

  def initialize(start, finish)
    @stations = [start, finish]
    register_instance
  end

  def add_station(station, place)
    if @stations.include?(station)
      puts 'Такая станция уже есть в маршруте'
    elsif place != 0 && place < @stations.size
      @stations.insert(place, station)
    else
      puts 'Нельзя добавить станцию на эту позицию'
    end
  end

  def delete_station(station)
    if [@stations.first, @stations.last].include?(station)
      puts 'Нельзя удалить начальную или конечную станцию'
    elsif @stations.include?(station)
      @stations.delete(station)
    else
      puts 'Такой станции нет в марштуре'
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
end
