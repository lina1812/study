require './lesson.rb'

loop do
  print_actions
  case gets.chomp.to_i
  when 0
    break
  when 1
    create_station
  when 2
    create_train
  when 3
    create_route
  when 4
    create_wagon
  when 5
    assign_route
  when 6
    route_change
  when 7
    train_change
  when 8
    moving_train
  when 9
    select_station
  when 10
    select_train
  when 11
    select_route
  when 12
    select_wagon
  when 13
    print_stations
  when 14
    list_of_train
  end
end
