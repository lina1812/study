# frozen_string_literal: true

require './train.rb'
require './station.rb'
require './route.rb'

station1 = Station.new('station1')
station2 = Station.new('station2')
station3 = Station.new('station3')

route1 = Route.new(station1, station2)
route1.add_station(station3, 1)

train = Train.new('train', 'грузовой', 31)
train1 = Train.new('train1', 'грузовой', 31)
train2 = Train.new('train2', 'пассажирский', 31)
train3 = Train.new('train3', 'пассажирский', 31)

train1.train_route(route1)
train2.train_route(route1)
train3.train_route(route1)

train2.moving_forward
train1.moving_forward
train1.moving_forward
train1.moving_forward
train1.moving_back
train1.moving_back
train1.moving_back

train.speed

train.stop
train.speed = 10
train.add_wagon
train.delete_wagon

train.stop
train.add_wagon
train.delete_wagon
