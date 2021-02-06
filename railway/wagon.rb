# frozen_string_literal: true

# Wagon description
class Wagon
  attr_accessor :number, :type, :train

  def initialize(number, type)
    @number = number
    @type = type
    @train = nil
  end
end
