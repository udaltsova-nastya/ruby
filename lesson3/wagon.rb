# Подключить модуль к классам Вагон и Поезд
require_relative 'manufacturer'

class Wagon
  include Manufacturer
  attr_reader :type, :taken_space

  def initialize(total_space = default_total_space)
    assign_type
    @total_space = total_space || default_total_space
    @taken_space = 0
  end

  def human_readable_type
    "обычный"
  end

  def take_space(space = default_take_space)
    return if free_space <= 0 
    @taken_space += space
  end

  def free_space
    @total_space - @taken_space
  end

  protected

  def assign_type
    @type = :standard
  end

  # Объем свободного места в вагоне по умолчанию
  def default_total_space
    0
  end

  # объем занимаемого места по умолчанию
  def default_take_space
    1
  end
end
