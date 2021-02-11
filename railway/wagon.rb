# frozen_string_literal: true

require './manufacturer.rb'
require './validatable.rb'

# Wagon description

class Wagon
  include Manufacturer
  include Validatable

  attr_accessor :number, :type, :train
  TYPE = %i[passenger cargo].freeze
  def initialize(number, type)
    @number = number
    @type = type
    @train = nil
    validate!
  end

  private

  def validate!
    raise "Wagon's number can't be nil" if number.nil?
    raise "Wagon's number should be at least 2 symbols" if number.length < 2
    raise "Wagon's type should be :passender of :cargo" unless TYPE.include?(type)
  end
end
