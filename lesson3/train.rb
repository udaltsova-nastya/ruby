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

# типы поездов относятся к классу в целом, поэтому ввела константы
# также ввела ограничение по скорости, потому что поезд не может разгоняться до бесконечности и шаг разгона

class Train
  TYPES = ["freight", "passenger"]
  MAX_SPEED = 100
  SPEED_STEP = 10

  attr_reader :speed, :cars_count, :route_current_station
    
  def initialize(number, type, cars_count)
    @number = number
    @type = type
    raise ArgumentError, "Укажите тип: 'freight' - грузовой или 'passenger' - пассажирский" unless TYPES.include?(@type)
    @cars_count = cars_count
    @speed = 0
  end

  def accelerate
    if @speed + SPEED_STEP <= MAX_SPEED
      @speed += SPEED_STEP
    else
      @speed = MAX_SPEED
    end
  end

  def decelerate
    return if stopped? 
    @speed -= SPEED_STEP
  end

  def stopped?
    @speed == 0
  end
  
  def add_car
    @cars_count += 1 if stopped?
  end
  
  def remove_car
    @cars_count -= 1 if stopped?
  end

  def set_route(route)
    @route = route
    @route_current_station = @route.stations.first
  end

  def route_current_station_index
    @route.stations.index(route_current_station)
  end

  def route_next_station
    return nil if @route_current_station == @route.stations.last
    @route.stations[route_current_station_index + 1]
  end

  def route_prev_station
    return nil if @route_current_station == @route.stations.first
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
