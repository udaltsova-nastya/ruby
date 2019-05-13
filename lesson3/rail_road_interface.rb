# frozen_string_literal: true

# Интерфейс для управления железной дорогой
class RailRoadInterface
  attr_reader :rail_road

  def initialize(rail_road)
    @rail_road = rail_road
  end

  def run
    loop do
      action = main_menu_action
      break if action.zero?

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

  # rubocop:disable Metrics/MethodLength
  # Ну, вот такое у нас большое меню...
  def train_menu_action
    puts "Управление поездами:"
    puts "0 - вернуться в главное меню"
    puts "1 - создать поезд"
    puts "2 - добавить вагон к поезду"
    puts "3 - отцепить вагон от поезда"
    puts "4 - назначить маршрут поезду"
    puts "5 - переместить поезд по маршруту вперед"
    puts "6 - переместить поезд по маршруту назад"
    puts "7 - занять место в вагоне"
    puts "8 - список поездов"
    puts "9 - список вагонов в поезде"
    gets.chomp.to_i
  end
  # rubocop:enable Metrics/MethodLength

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

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
  # Ну, вот такое у нас большое меню...
  def train_menu_process(action)
    case action
    when 1
      create_train
    when 2
      add_wagon_to_train
    when 3
      remove_wagon_from_train
    when 4
      assign_route_to_train
    when 5
      move_train_forward
    when 6
      move_train_backward
    when 7
      occupy_wagon
    when 8
      show_trains_list
    when 9
      show_train_wagons_list
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength

  def station_menu_process(action)
    case action
    when 1
      create_station(ask_station_name)
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

  def ask_station_name
    puts "Введите название станции:"
    gets.chomp
  end

  def find_or_create_station
    rail_road.find_or_create_station(ask_station_name)
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
    rail_road.find_station(ask_station_name)
  end

  def show_trains_list_on_station(station)
    if station
      puts "Список поездов на станции #{station.name}:"
      show_trains_list(station.trains)
    else
      puts "Станция не найдена"
    end
  end

  # Отображаем переданный список поездов
  # Если список поездов не передан, то отображаем список всех поездов на железной дороге
  def show_trains_list(trains = rail_road.trains)
    trains.each.with_index(1) do |train, index|
      # print -- чтобы не было лишнего перевода на новую строку
      print "#{index}. Поезд #{train.human_readable_type} № #{train.number}, вагонов #{train.wagons_count}"
      print ", занято #{train.taken_space} "
      puts ", доступно : #{train.free_space} "
    end
  end

  def show_train_wagons_list
    train = select_train
    if train
      train.iterate_wagons do |wagon, wagon_number|
        print "#{wagon_number}. Вагон #{wagon.human_readable_type}"
        print ", занятo: #{wagon.taken_space}"
        puts ", свободнo: #{wagon.free_space}"
      end
    else
      puts "Поезд не найден"
    end
  end

  def create_station(station_name)
    rail_road.create_station(station_name)
  end

  def create_route
    first_station_name = ask_station_name
    last_station_name = ask_station_name
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

  def ask_train_type
    puts "Введите тип поезда:"
    puts "1 - пассажирский (по умолчанию)"
    puts "2 - грузовой"
    train_type = gets.chomp.to_i
    case train_type
    when 1
      :passenger
    when 2
      :cargo
    end
  end

  def ask_train_number
    puts "Введите номер поезда"
    gets.chomp
  end

  def create_train
    train_type = ask_train_type
    train_number = ask_train_number
    train = rail_road.create_train(train_type, train_number)
    puts "Создан #{train}"
  rescue ArgumentError => e
    puts "Не удалось создать поезд:"
    puts e.message
    retry
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
      wagon_attributes = ask_wagon_attributes(train)
      rail_road.add_wagon_to_train(train, wagon_attributes)
    else
      puts "Поезд не найден"
    end
    puts "Вагон добавлен к поезду №#{train.number}"
    puts "Общее количество вагонов в поезде: #{train.wagons_count}"
  end

  def ask_wagon_attributes(train)
    case train.type
    when :cargo
      ask_cargo_wagon_attributes
    when :passenger
      ask_passenger_wagon_attributes
    end
  end

  def ask_passenger_wagon_attributes
    puts "Укажите кол-во мест в вагоне"
    puts "По умолчанию #{rail_road.passenger_wagon_default_seats_count} мест"
    seats_count = gets.chomp.to_i
    seats_count = nil if seats_count.zero?
    seats_count
  end

  def ask_cargo_wagon_attributes
    puts "Укажите вместимость вагона (в тоннах)"
    puts "По умолчанию #{rail_road.cargo_wagon_default_volume} тонн"
    volume = gets.chomp.to_i
    volume = nil if volume.zero?
    volume
  end

  def occupy_wagon
    train = select_train
    puts "Поезд не найден" && return unless train

    wagon = select_wagon(train)
    puts "Вагон не найден" && return unless wagon

    occupy_wagon_by_type(wagon)
  end

  def occupy_wagon_by_type(wagon)
    case wagon.type
    when :passenger
      occupy_passenger_wagon(wagon)
    when :cargo
      occupy_cargo_wagon(wagon)
    else
      puts "Невозможно загрузить или занять место в данном типе вагона"
    end
  end

  def occupy_passenger_wagon(wagon)
    if wagon.take_space
      puts "Место в вагоне успешно занято"
      puts "Осталось свободных мест: #{wagon.free_space}"
    else
      puts "Не удалось занять место в вагоне"
    end
  end

  def occupy_cargo_wagon(wagon)
    puts "Доступно для загрузки #{wagon.free_space} тонн"
    puts "Укажите объем загрузки (в тоннах):"
    space = gets.chomp.to_i
    if wagon.take_space(space)
      puts "Вагон успешно загружен"
      puts "Осталось свободного места для загрузки: #{wagon.free_space}"
    else
      puts "Не удалось загрузить вагон"
    end
  end

  def select_wagon(train)
    return nil if train.wagons_count.zero?

    puts "Выберите вагон: от 1 до #{train.wagons_count}"
    wagon_index = gets.chomp.to_i - 1
    train.wagons[wagon_index]
  end

  def remove_wagon_from_train
    train = select_train
    if train
      train.remove_wagon
    else
      puts "Поезд не найден"
    end
  end

  def assign_route_to_train
    train = select_train
    puts "Поезд не найден" && return unless train

    route = select_route
    puts "Маршрут не найден" && return unless route

    train.assign_route(route)
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
