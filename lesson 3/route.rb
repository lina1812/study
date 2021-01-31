# frozen_string_literal: true

# All route logic
class Route
  attr_accessor :route

  def initialize(start, finish)
    @route = [start, finish]
  end

  def add_station(station, place)
    if @route.include?(station)
      puts 'Такая станция уже есть в маршруте'
    elsif place != 0 && place < @route.size
      @route.insert(place, station)
    else
      puts 'Нельзя добавить станцию на эту позицию'
    end
  end

  def delete_station(station)
    if [@route.first, @route.last].include?(station)
      puts 'Нельзя удалить начальную или конечную станцию'
    elsif @route.include?(station)
      @route.delete(station)
    else
      puts 'Такой станции нет в марштуре'
    end
  end

  def next_station(current_station)
    route[route.index(current_station) + 1] if current_station != route.last && route.include?(current_station)
  end

  def previous_station(current_station)
    route[route.index(current_station) - 1] if current_station != route.first && route.include?(current_station)
  end
end
