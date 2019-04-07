# Маршрут
# 1. Имеет начальную и конечную станцию,
# 1.1.  а также список промежуточных станций.
# 2. Начальная и конечная станции указываются при создании маршрута,
# 2.1. а промежуточные могут добавляться между ними.
# 3. Может добавлять промежуточную станцию в список
# 4. Может удалять промежуточную станцию из списка
# 5. Может выводить список всех станций по-порядку от начальной до конечной

class Route
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @middle_stations = []
  end

  def add_station(name)
   middle_stations << name
  end

  def remove_station(name)
    middle_stations.delete(name)
  end

  def stations
    [first_station] + middle_stations + [last_station]
  end
end 

