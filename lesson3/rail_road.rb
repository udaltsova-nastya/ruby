# поезда, маршруты, станции
class RailRoad
  attr_reader :trains, :stations, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end
  
  # возвращает станции по имени (объект класса), либо nil, если станция не найдена
  def find_station(station_name)
    @stations.find { |station| station.name == station_name }
  end

  # создает и возвращает созданную станцию
  def create_station(station_name)
    new_station = Station.new(station_name)
    @stations << new_station
    new_station
  end

  # Создаем станцию по названию станции, если она еще не создана
  # Возвращаем существующую станцию (объект класса), если она уже есть с таким именем
  # или создаем и возвращаем новую станцию
  def find_or_create_station(station_name)
    station = find_station(station_name)
    return station if station
    create_station(station_name)
  end

  # создает и возвращает новый маршрут с указанием первой и последней станций
  def create_route(first_station_name, last_station_name)
    first_station = find_or_create_station(first_station_name)
    last_station = find_or_create_station(last_station_name)
    new_route = Route.new(first_station, last_station)
    @routes << new_route
    new_route
  end

  def find_route(route_name)
    @routes.find { |route| route.name == route_name }
  end
  
  # создаем поезд указанного типа, по умолчанию - пассажирский
  def create_train(train_type, train_number)
    if train_type == 2
      new_train = CargoTrain.new(train_number)
    else
      new_train = PassengerTrain.new(train_number)
    end
    @trains << new_train
    new_train 
  end

  # поиск поезда по его номеру
  def find_train(train_number)
    @train.find { |train| train.number == train_number }
  end

  def cargo_wagon_default_volume
    CargoWagon::DEFAULT_VOLUME
  end

  def passenger_wagon_default_seats_count 
    PassengerWagon::DEFAULT_SEATS_COUNT
  end

  def create_wagon_by_type(type, wagon_attributes)
    case type
    when :standard
      Wagon.new
    when :passenger
      PassengerWagon.new(total_seats_count: wagon_attributes)
    when :cargo
      CargoWagon.new(total_volume: wagon_attributes)
    end
  end

  def add_wagon_to_train(train, wagon_attributes)
    new_wagon = create_wagon_by_type(train.type, wagon_attributes)
    train.add_wagon(new_wagon)
  end
end
