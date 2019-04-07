# Поезд
# 1. Имеет
#   номер (произвольная строка)
#   тип (грузовой, пассажирский)
#   количество вагонов
#   эти данные указываются при создании экземпляра класса
# 2. Может набирать скорость
# 3. Может возвращать текущую скорость
# 4. Может тормозить (сбрасывать скорость до нуля)
# 5. Может возвращать количество вагонов
# 6. Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
# 6.1. Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# 7. Может принимать маршрут следования (объект класса Route). 
# 8. При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# 9. Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# 10. Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

class Train
  attr_reader :speed
  attr_reader :cars_count
  attr_reader :route_current_station
  
  def initialize (number, type, cars_count)
    types = ["freight", "passenger"]

    @number = number
    @type = type
    raise ArgumentError, "Укажите тип: 'freight' - грузовой или 'passenger' - пассажирский" unless types.include?(@type)
    @cars_count = cars_count
    @speed = 0
    @route = nil
    @route_current_station = nil
  end

  def go
    @speed = 100
  end

  def stop
    @speed = 0
  end

  def stopped?
    @speed == 0
  end
  
  def add_car
    @cars_count = cars_count += 1 if stopped?
  end
  
  def remove_car
    @cars_count = cars_count -= 1 if stopped?
  end

  def set_route(route)
    @route = route
    @route_current_station = @route.stations.first
  end

  def route_current_station_index
    @route.stations.index(route_current_station)
  end

  def route_next_station
    return nil if route_current_station_index >= @route.stations.count - 1
    @route.stations[route_current_station_index + 1]
  end

  def route_prev_station
    return nil if route_current_station_index < 1
    @route.stations[route_current_station_index - 1]
  end

  def move_forward
    raise StandardError, "Не задан маршрут" unless @route
    raise StandardError, "Поезд уже на последней станции маршрута" unless route_next_station
    @route_current_station = route_next_station
  end

  def move_backward
    raise StandardError, "Не задан маршрут" unless @route
    raise StandardError, "Поезд уже на первой станции маршрута" unless route_prev_station
    @route_current_station = route_prev_station
  end
end
