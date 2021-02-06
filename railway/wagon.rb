# frozen_string_literal: true

require './manufacturer.rb'

# Wagon description
class Wagon
  include Manufacturer
  attr_accessor :number, :type, :train

  def initialize(number, type)
    @number = number
    @type = type
    @train = nil
  end
end
