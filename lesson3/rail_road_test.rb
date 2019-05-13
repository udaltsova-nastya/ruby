# frozen_string_literal: true

# Создает тестовые данные (станции, поезда, вагоны) и связывает их между собой
module RailRoadTest
  STATION_NAMES = [
    "Урýчча",
    "Бары́саўскі тра́кт",
    "Усхо́д",
    "Маско́ўская",
    "Па́рк Чалю́скінцаў",
    "Акадэ́мія наву́к",
    "Плóшча Якýба Кóласа",
    "Плóшча Перамóгі",
    "Кастры́чніцкая",
    "Плóшча Лéніна",
    "Инстытýт Культýры",
    "Грýшаўка",
    "Міхалóва",
    "Пятрóўшчына",
    "Малінаўка"
  ].freeze

  # Используем class << self, чтобы можно было вызвать метод:
  # RailRoadTest.init(rail_road)
  class << self
    def init(rail_road)
      @rail_road = rail_road
      @stations = {}
      create_stations
      create_routes
      create_trains
    end

    private

    def create_stations
      # ключ: название станции -> значение: объект "станция"
      STATION_NAMES.each do |station_name|
        @stations[station_name] = @rail_road.find_or_create_station(station_name)
      end
    end

    def create_routes
      @route = @rail_road.create_route("Урýчча", "Малінаўка")
      # Добавляем промежуточные станции в маршрут
      # (все, кроме первой и последней в списке)
      STATION_NAMES[1..-2].each.with_index(1) do |station_name, index|
        @route.add_station(index, @stations[station_name])
      end
    end

    def create_trains
      train1 = @rail_road.create_train(:passenger, "aaa-99")
      train2 = @rail_road.create_train(:cargo, "ccc-66")

      @rail_road.add_wagon_to_train(train1)
      @rail_road.add_wagon_to_train(train1, 50)
      @rail_road.add_wagon_to_train(train2)
      @rail_road.add_wagon_to_train(train2, 60)

      train1.assign_route(@route)
      train2.assign_route(@route)
    end
  end
end
