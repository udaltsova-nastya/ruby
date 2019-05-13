# frozen_string_literal: true

# Добавить атрибут общего объема (задается при создании вагона)
# Добавить метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
# Добавить метод, который возвращает занятый объем
# Добавить метод, который возвращает оставшийся (доступный) объем
class CargoWagon < Wagon
  DEFAULT_VOLUME = 70 # тонн

  def human_readable_type
    "грузовой"
  end

  protected

  def assign_type
    @type = :cargo
  end

  def default_total_space
    DEFAULT_VOLUME
  end
end
