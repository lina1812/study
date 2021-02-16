# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
    base.class_variable_set('@@validation_rules', [])
  end

  module ClassMethods
    def validate(name, type, rule = nil)
      var_name = "@#{name}".to_sym
      class_variable_get('@@validation_rules') << [var_name, type, rule]
    end
  end

  module InstanceMethods
    def validate!
      self.class.class_variable_get('@@validation_rules').each do |rule|
        raise "#{rule[0]} can't be nil" if rule[1] == :presence && !instance_variable_defined?(rule[0])
        raise "#{rule[0]} has invalid format" if rule[1] == :format && instance_variable_get(rule[0]) !~ rule[2]
        raise "#{rule[0]} should be a #{rule[3]}" if rule[1] == :type && instance_variable_get(rule[0]).is_a?(rule[3])
      end
      true
    end

    def valid?
      validate!
    rescue StandardError
      false
    end
  end
end
