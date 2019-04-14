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
require_relative "rail_road_interface"

RailRoadIneterface.new.run 
  
