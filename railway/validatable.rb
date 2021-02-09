# frozen_string_literal: true

module Validatable
  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
