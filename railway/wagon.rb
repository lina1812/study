# frozen_string_literal: true

require './manufacturer.rb'
require './validation.rb'

# Wagon description

class Wagon
  include Manufacturer
  include Validation

  attr_accessor :number, :type, :train
  TYPE = %i[passenger cargo].freeze
  VALID_NUMBER = /.+/i.freeze

  validate :number, :presence
  validate :number, :format, VALID_NUMBER
  validate :type, :presence

  def initialize(number, _arg2)
    @number = number
    @type = initial_type
    @train = nil
    validate!
  end

  def print_wagon
    puts "Wagon's number: #{number}"
    puts "Wagon's type: #{type}"
  end
end
