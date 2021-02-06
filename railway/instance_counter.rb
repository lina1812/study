# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    @@count = {}

    def instances
      @@count[self]
    end

    def add_instance(_class_name)
      @@count[self] = 0 if @@count[self].nil?
      @@count[self] += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.add_instance(self.class)
    end
  end
end
