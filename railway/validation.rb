# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
    base.class_variable_set('@@validations', [])
  end

  module ClassMethods
    def validate(name, type, rule = nil)
      var_name = "@#{name}".to_sym
      class_variable_get('@@validations') << { attr: var_name, type: type, options: rule }
    end
  end

  module InstanceMethods
    def validate!
      self.class.class_variable_get('@@validations').each do |rule|
        send("validate_#{rule[:type]}", **rule)
      end
      true
    end

    def validate_presence(attr:, **)
      raise "#{attr} can't be nil" if !instance_variable_defined?(attr) && instance_variable_get(attr) != ''
    end

    def validate_format(attr:, options:, **)
      raise "#{attr} has invalid format" if instance_variable_get(attr) !~ options
    end

    def validate_type(attr:, options:, **)
      raise "#{attr} should be a #{options}" if instance_variable_get(attr).is_a?(options)
    end

    def valid?
      validate!
    rescue StandardError
      false
    end
  end
end
