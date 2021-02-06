module Manufacturer
  def add_manufacturer(name)
    self.manufacturer = name
  end

  def manufacturer_name
    manufacturer
  end

  protected

  attr_accessor :manufacturer
end
