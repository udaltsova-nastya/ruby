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
  attr_reader :speed, :route_current_station, :number, :type
    
  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    assign_type
  end

  def accelerate
    if @speed + speed_step <= max_speed
      @speed += speed_step
    else
      @speed = max_speed
    end
  end

  def decelerate
    return if stopped? 
    @speed -= speed_step
  end

  def stopped?
    @speed == 0
  end
  
  def add_wagon(wagon)
    raise ArgumentError, "Выберите вагон согласно типу поезда" unless valid_wagon_type?(wagon)
    return unless stopped?
    @wagons << wagon
  end
  
  # удаляет последний вагон из поезда
  def remove_wagon
    return unless stopped?
    @wagons.pop
  end

  def wagons_count
    @wagons.size
  end
  # назначение маршрута, при назначении маршрута поезд перемещается на первую станцию маршрута
  def set_route(route)
    @route = route
    move_to_route_first_station
  end

  def route_next_station
    return nil if @route_current_station == @route.stations.last
    @route.stations[route_current_station_index + 1]
  end

  def route_prev_station
    return nil if @route_current_station == @route.stations.first
    @route.stations[route_current_station_index - 1]
  end

  # Перемещение вперед по маршруту на одну станцию
  def move_forward
    raise StandardError, "Не задан маршрут" unless @route
    raise StandardError, "Поезд уже на последней станции маршрута" unless route_next_station
    remove_self_from_station(@route_current_station)
    @route_current_station = route_next_station
    add_self_to_station(@route_current_station)
  end

  def move_backward
    raise StandardError, "Не задан маршрут" unless @route
    raise StandardError, "Поезд уже на первой станции маршрута" unless route_prev_station
    remove_self_from_station(@route_current_station)
    @route_current_station = route_prev_station
    add_self_to_station(@route_current_station)
  end

  protected

  # эти методы можно переопределить в подклассах 

  def max_speed
    200
  end

  def speed_step
    10
  end

  # установить тип поезда
  def assign_type
    @type = :standard
  end 

  # проверка что переданный вагон имеет соответствующий поезду тип (пассажирский или грузовой)
  def valid_wagon_type?(wagon)
    wagon.type == @type
  end

  private

  # это внутренний метод, не требует переопределения
  def route_current_station_index
    @route.stations.index(@route_current_station)
  end

  def move_to_route_first_station
    @route_current_station = @route.stations.first
    add_self_to_station(@route_current_station)
  end

  # уведомляем станцию, что на нее прибыл поезд
  def add_self_to_station(station)
    station.add_train(self)
  end

  # уведомляем станцию, что поезд с нее убыл
  def remove_self_from_station(station)
    station.remove_train(self)
  end
end
