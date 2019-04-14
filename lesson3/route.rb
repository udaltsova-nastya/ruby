# Маршрут
# 1. Имеет начальную и конечную станцию,
# 1.1.  а также список промежуточных станций.
# 2. Начальная и конечная станции указываются при создании маршрута,
# 2.1. а промежуточные могут добавляться между ними.
# 3. Может добавлять промежуточную станцию в список
# 4. Может удалять промежуточную станцию из списка
# 5. Может выводить список всех станций по-порядку от начальной до конечной

class Route
  attr_reader :name

  def initialize(route_name, first_station, last_station)
    @name = route_name
    @first_station = first_station
    @last_station = last_station
    @middle_stations = []
  end
  # по условию пользователь может добавлять и удалять только промежуточные станции. 
  # Оставила свое решение, чтобы не вводить дополнительную проверку на предмет неприкосновенности
  # первой и последней станций
  def add_station(index, name)
    middle_stations.insert(index, name)
  end

  def remove_station(name)
    middle_stations.delete(name)
  end

  def stations
    [first_station] + middle_stations + [last_station]
  end
end 

