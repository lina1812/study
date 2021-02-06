# frozen_string_literal: true

# Cargo train description
class CargoTrain < Train
  def initialize(number)
    super
    register_instance
  end

  def initial_type
    :cargo
  end
end
