# Добавить атрибут общего объема (задается при создании вагона)
# Добавить метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
# Добавить метод, который возвращает занятый объем
# Добавить метод, который возвращает оставшийся (доступный) объем
class CargoWagon < Wagon
  DEFAULT_VOLUME = 70 # тонн
  attr_reader :taken_volume

  def initialize(total_volume: DEFAULT_VOLUME)
    super()
    @total_volume = total_volume || DEFAULT_VOLUME
    @taken_volume = 0
  end

  def take_volume(volume)
    return if free_volume < volume
    @taken_volume += volume
  end

  def free_volume
    @total_volume - @taken_volume
  end

  def human_readable_type
    "грузовой"
  end

  protected
  
  def assign_type
    @type = :cargo
  end
end
