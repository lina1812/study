# frozen_string_literal: true

require './instance_counter.rb'
require './validation.rb'

# All station logic
class Station
  include InstanceCounter
  include Validation

  attr_reader :trains, :name

  # rubocop:disable Style/ClassVars
  @@stations = []
  # rubocop:enable Style/ClassVars
  VALID_NAME = /.+/i.freeze

  validate :name, :presence
  validate :name, :format, VALID_NAME

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def take_a_train(train)
    raise 'This train is already at the station' if @trains.include?(train)

    @trains << train
  end

  def send_a_train(train)
    raise "This train isn't at the station" unless @trains.include?(train)

    @trains.delete(train)
  end

  def self.all
    @@stations
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }.count
  end

  def each_train
    @trains.each do |train|
      yield(train)
    end
  end
end
