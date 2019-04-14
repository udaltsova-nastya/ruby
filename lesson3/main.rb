# Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
# Станции
#  - Создавать станции
#  - Просматривать список станций
#  - список поездов на конкретной станции
# Маршруты
#  - Создавать маршруты
#  - управлять станциями в нем (добавлять, удалять)
# Поезда
#  - Создавать поезда
#  - Добавлять вагоны к поезду
#  - Отцеплять вагоны от поезда
#  - Назначать маршрут поезду
#  - Перемещать поезд по маршруту вперед
#  - Перемещать поезд по маршруту назад
require_relative "train"
require_relative "cargo_train"
require_relative "passenger_train"

require_relative "wagon"
require_relative "cargo_wagon"
require_relative "passenger_wagon"

require_relative "route"
require_relative "station"
require_relative "rail_road"

rail_road = Rail_road.new

loop do
  puts "Выберите действие:"
  puts "0 - завершить работу с программой"
  puts "1 - управление поездами"
  puts "2 - управление станциями"
  puts "3 - управление маршрутами"

  action = gets.chomp.to_i

  case action
  when 0
    puts "Завершение программы"
    break
  when 1
    puts "Управление поездами:"
    puts "0 - вернуться в главное меню"
    puts "1 - создать поезд"
    puts "2 - добавить вагон к поезду"
    puts "3 - отцепить вагон от поезда"
    puts "4 - назначить маршрут поезду"
    puts "5 - переместить поезд по маршруту вперед"
    puts "6 - переместить поезд по маршруту назад"

    action = gets.chomp.to_i
    сase action

    when 0
    # программа продолжит выполнение с начала цикла  
    when 1
      puts "Создание поезда:"
      # пассажирский ввела по умолчнию, чтобы не добавлять проверку, если вдруг пользователь введет не ту цифру
      puts "Введите тип поезда:"
      puts "1 - пассажирский (по умолчанию)"
      puts "2 - грузовой"
      train_type = gets.chomp.to_i
      puts "Введите номер"
      train_number = gets.chomp.to_i
      rail_road.create_train(train_type, train_number)

    when 2
      puts "Введите номер поезда"
      train_number = gets.chomp.to_i
      train = rail_road.find_train(train_number)
      if train
        rail_road.add_wagon_to_train(train)
      else
        puts "Поезд не найден"
      end

    when 3
      puts "Введите номер поезда"
      train_number = gets.chomp.to_i
      train = rail_road.find_train(train_number)
      if train
        train.remove_wagon
      else
        puts "Поезд не найден"
      end

    when 4
      puts "Введите номер поезда"
      train_number = gets.chomp.to_i
      train = rail_road.find_train(train_number)
      if train
        puts "Введите название маршрута"
        route_name = gets.chomp
        route = rail_road.find_route(route_name)
        if route
          train.set_route(route)
        else
          puts "Маршрут не найден"
        end
      else
        puts "Поезд не найден"
      end

      when 5
        puts "Введите номер поезда"
        train_number = gets.chomp.to_i
        train = rail_road.find_train(train_number)
        if train
          train.move_forward
        else
          puts "Поезд не найден"
        end

      when 6
        puts "Введите номер поезда"
        train_number = gets.chomp.to_i
        train = rail_road.find_train(train_number)
        if train
          train.move_backward
        else
          puts "Поезд не найден"
        end


  when 2
    puts "Управление станциями:"
    puts "0 - вернуться в главное меню"
    puts "1 - создать станцию"
    puts "2 - вывести список станций"
    puts "3 - получить список поездов на станции"
    
    action = gets.chomp.to_i
    сase action
    
    when 0
    # программа продолжит выполнение с начала цикла  
    when 1
      puts "Введите название станции"
      station_name = gets.chomp
      rail_road.create_station(station_name)
    when 2
      puts "Список станций:"
      puts stations
    when 3
      puts "Введите название стации"
      station_name = gets.chomp
      station = rail_road.find_station(station_name)
      if station
        puts "Список поездов на станции #{station_name}:"
        station.trains.each do |train|
          puts train.number
        end
      else
        puts "Станция не найдена"
      end
    end
  when 3
    puts "Управление маршрутами:" 
    puts "0 - вернуться в главное меню"
    puts "1 - создать маршрут" 
    puts "2 - добавить станцию в маршрут" 
    puts "3 - удалить станцию из маршрута"

    action = gets.chomp.to_i
    сase action
    when 0
    # программа продолжит выполнение с начала цикла  
    when 1
      puts "Введите название маршрута"
      route_name = gets.chomp
      puts "Введите начальную станцию"
      first_station_name = gets.chomp
      puts "Введите конечную станцию"
      last_station_name = gets.chomp
      rail_road.create_route(route_name, first_station_name, last_station_name) 
     
    when 2
      puts "Введите название маршрута"
      route_name = gets.chomp
      route = rail_road.find_route(route_name)
      if route
        puts "Введите название станции"
        station_name = gets.chomp
        puts "Введите порядковый номер станции в маршруте"
        station_index = gets.chomp.to_i
        route.add_station(station_index, station_name)
      else
        puts "Маршрут не найден"
      end

    when 3
      puts "Введите название маршрута"
      route_name = gets.chomp
      route = rail_road.find_route(route_name)
      if route
        puts "Введите название станции"
        station_name = gets.chomp
        puts "Введите порядковый номер станции в маршруте"
        station_index = gets.chomp.to_i
        route.remove_station(station_index, station_name)
      else
        puts "Маршрут не найден"
      end
    end
  end
end
