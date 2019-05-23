# frozen_string_literal: true

require_relative "instance_counter"
require_relative "validation"
require_relative "station"

# Маршрут
# 1. Имеет начальную и конечную станцию,
# 1.1.  а также список промежуточных станций.
# 2. Начальная и конечная станции указываются при создании маршрута,
# 2.1. а промежуточные могут добавляться между ними.
# 3. Может добавлять промежуточную станцию в список
# 4. Может удалять промежуточную станцию из списка
# 5. Может выводить список всех станций по-порядку от начальной до конечной
class Route
  include InstanceCounter
  include Validation

  attr_reader :name

  validate :first_station, :presence
  validate :first_station, :type, Station
  validate :last_station, :presence
  validate :last_station, :type, Station
  validate :middle_stations, :type, [Station]

  def initialize(first_station, last_station)
    @name = "#{first_station.name} - #{last_station.name}"
    @first_station = first_station
    @last_station = last_station
    @middle_stations = []
    validate!

    register_instance
  end

  # по условию пользователь может добавлять и удалять только промежуточные станции.
  # Оставила свое решение, чтобы не вводить дополнительную проверку на предмет неприкосновенности
  # первой и последней станций
  def add_station(index, station)
    @middle_stations.insert(index - 1, station)
    validate!
  end

  def remove_station(station)
    @middle_stations.delete(station)
  end

  def stations
    [@first_station] + @middle_stations + [@last_station]
  end
end
