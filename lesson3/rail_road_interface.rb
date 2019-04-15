class RailRoadInterface
  attr_reader :rail_road

  def initialize
    @rail_road = RailRoad.new
  end

  def run
    loop do
      action = main_menu_action
      break if action == 0

      main_menu_process(action)
    end
  end

  private

  # отображаем главное меню и возвращаем выбор пользователя
  def main_menu_action
    puts "Выберите действие:"
    puts "0 - завершить работу с программой"
    puts "1 - управление поездами"
    puts "2 - управление станциями"
    puts "3 - управление маршрутами"
    gets.chomp.to_i
  end

  def train_menu_action
    puts "Управление поездами:"
    puts "0 - вернуться в главное меню"
    puts "1 - создать поезд"
    puts "2 - добавить вагон к поезду"
    puts "3 - отцепить вагон от поезда"
    puts "4 - назначить маршрут поезду"
    puts "5 - переместить поезд по маршруту вперед"
    puts "6 - переместить поезд по маршруту назад"
    gets.chomp.to_i
  end

  def station_menu_action
    puts "Управление станциями:"
    puts "0 - вернуться в главное меню"
    puts "1 - создать станцию"
    puts "2 - вывести список станций"
    puts "3 - получить список поездов на станции"
    gets.chomp.to_i
  end

  def route_menu_action
    puts "Управление маршрутами:"
    puts "0 - вернуться в главное меню"
    puts "1 - создать маршрут" 
    puts "2 - добавить станцию в маршрут" 
    puts "3 - удалить станцию из маршрута"
    gets.chomp.to_i
  end


  def main_menu_process(action)
    case action
    when 1
      train_menu_process(train_menu_action)
    when 2
      station_menu_process(station_menu_action)
    when 3
      route_menu_process(route_menu_action)
    end
  end

  def train_menu_process(action)
    case action
    when 1
      create_train
    when 2
      add_wagon_to_train
    when 3
      remove_wagon_from_train
    when 4
      set_route_to_train
    when 5
      move_train_forward
    when 6 
      move_train_backward
    end
  end

  def station_menu_process(action)
    case action
    when 1
      create_station(get_station_name)
    when 2
      show_stations_list
    when 3
      show_trains_list_on_station(find_station)
    end
  end

  def route_menu_process(action)
    case action
    when 1
      create_route
    when 2
      add_station_to_route
    when 3
      remove_station_from_route
    end
  end

  def get_station_name
    puts "Введите название станции:"
    gets.chomp
  end

  def find_or_create_station
    rail_road.find_or_create_station(get_station_name)
  end

  def show_stations_list
    puts "Список станций:"
    rail_road.stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
  end

  def show_routes_list
    puts "Список маршрутов:"
    rail_road.routes.each.with_index(1) do |route, index|
      puts "#{index} - #{route.name}"
    end
  end

  def find_station
    rail_road.find_station(get_station_name)
  end

  def show_trains_list_on_station(station)
    if station
      puts "Список поездов на станции #{station_name}:"
      show_trains_list(station.trains)
    else
      puts "Станция не найдена"
    end
  end

  def show_trains_list
    rail_road.trains.each.with_index(1) do |train, index|
      puts "#{index}. Поезд #{train.number}, вагонов #{train.wagons_count}, тип #{train.type}"
    end
  end

  def create_station(station_name)
    rail_road.create_station(station_name)
  end

  def create_route
    first_station_name = get_station_name
    last_station_name = get_station_name
    rail_road.create_route(first_station_name, last_station_name)
  end

  def add_station_to_route
    route = select_route
    if route
      station = find_or_create_station
      puts "Введите порядковый номер станции в маршруте"
      station_index = gets.chomp.to_i
      route.add_station(station_index, station)
    else
      puts "Маршрут не найден"
    end

    def remove_station_from_route
      route = select_route
      if route
        station = find_station
        route.remove_station(station)
      else
        puts "Маршрут не найден"
      end
    end
  end

  def get_train_type
    puts "Введите тип поезда:"
    puts "1 - пассажирский (по умолчанию)"
    puts "2 - грузовой"
    gets.chomp.to_i
  end

  def get_train_number
    puts "Введите номер поезда"
    gets.chomp.to_i
  end

  def create_train
    train_type = get_train_type
    train_number = get_train_number
    rail_road.create_train(train_type, train_number) 
  end

  def select_train
    puts "Выберите поезд:"
    show_trains_list
    train_index = gets.chomp.to_i - 1
    rail_road.trains[train_index]
  end

  def select_route
    puts "Выберите маршрут:"
    show_routes_list
    route_index = gets.chomp.to_i - 1
    rail_road.routes[route_index]
  end

  def add_wagon_to_train
    train = select_train
    if train
      rail_road.add_wagon_to_train(train)
    else
      puts "Поезд не найден"
    end
  end

  def remove_wagon_from_train
    train = select_train
    if train
      train.remove_wagon
    else
      puts "Поезд не найден"
    end  
  end

  def set_route_to_train
    train = select_train
    if train
      route = select_route
      if route
        train.set_route(route)
      else
        puts "Маршрут не найден"
      end
    else
      puts "Поезд не найден"
    end
  end

  def move_train_forward
    train = select_train
    if train
      train.move_forward
    else
      puts "Поезд не найден"
    end
  end

  def move_train_backward
    train = select_train
    if train
      train.move_backward
    else
      puts "Поезд не найден"
    end 
  end
end
