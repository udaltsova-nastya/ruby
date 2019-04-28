# Маршрут
# 1. Имеет начальную и конечную станцию,
# 1.1.  а также список промежуточных станций.
# 2. Начальная и конечная станции указываются при создании маршрута,
# 2.1. а промежуточные могут добавляться между ними.
# 3. Может добавлять промежуточную станцию в список
# 4. Может удалять промежуточную станцию из списка
# 5. Может выводить список всех станций по-порядку от начальной до конечной
require_relative "instance_counter"
require_relative "errors_list"

class Route
  include InstanceCounter
  include ErrorsList

  attr_reader :name

  def initialize(first_station, last_station)
    validate_stations(first_station, last_station)
    raise_on_validations_error

    @name = "#{first_station.name} - #{last_station.name}"
    @first_station = first_station
    @last_station = last_station
    @middle_stations = []
    register_instance
  end

  # по условию пользователь может добавлять и удалять только промежуточные станции. 
  # Оставила свое решение, чтобы не вводить дополнительную проверку на предмет неприкосновенности
  # первой и последней станций
  def add_station(index, station)
    validate_station(station, "Промежуточная станция")
    raise_on_validations_error

    @middle_stations.insert(index - 1, station)
  end

  def remove_station(station)
    validate_station(station, "Промежуточная станция")
    raise_on_validations_error

    @middle_stations.delete(station)
  end

  def stations
    [@first_station] + @middle_stations + [@last_station]
  end

  protected

  def validate_stations(first_station, last_station)
    validate_station(first_station, "Первая станция")
    validate_station(last_station, "Последняя станция")
  end

  def validate_station(station, station_label)
    add_error("#{station_label} должна быть задана") if station.nil?
    add_error("#{station_label} должна иметь название (name)") unless station.respond_to?(:name)
  end
end
