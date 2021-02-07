# frozen_string_literal: true

# Passenger train description

class PassengerTrain < Train
  def initialize(number)
    super
    register_instance
  end

  def initial_type
    :passenger
  end
end
