# Подключить модуль к классам Вагон и Поезд
require_relative 'manufacturer'

class Wagon
  include Manufacturer
  attr_reader :type

  def initialize
    assign_type 
  end

  protected

  def assign_type
    @type = :standard
  end
end
