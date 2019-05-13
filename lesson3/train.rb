# frozen_string_literal: true

require_relative "train_routes"
require_relative "manufacturer"
require_relative "instance_counter"
require_relative "errors_list"

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
# 6. Может прицеплять/отцеплять вагоны (по одному вагону за операцию)
#    метод просто увеличивает или уменьшает количество вагонов).
# 6.1. Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# 7. Может принимать маршрут следования (объект класса Route).
# 8. При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
# 9. Может перемещаться между станциями, указанными в маршруте.
#    Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# 10. Возвращать предыдущую станцию, текущую, следующую, на основе маршрута

# типы поездов относятся к классу в целом, поэтому ввела константы
# также ввела ограничение по скорости, потому что поезд не может разгоняться до бесконечности и шаг разгона
# Подключить модуль к классам Вагон и Поезд
# Добавить к поезду атрибут Номер (произвольная строка), если его еще нет, который указыватеся при его создании
# В классе Train создать метод класса find, который принимает номер поезда (указанный при его создании)
# и возвращает объект поезда по номеру или nil, если поезд с таким номером не найден.
# написать метод, который принимает блок и проходит по всем вагонам поезда (вагоны должны быть во внутреннем массиве),
# передавая каждый объект вагона в блок.
class Train
  include TrainRoutes
  include Manufacturer
  include InstanceCounter
  include ErrorsList

  # три буквы или цифры в любом порядке, необязательный дефис (может быть, а может нет)
  # и еще 2 буквы или цифры после дефиса
  NUMBER_PATTERN = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i.freeze

  attr_reader :speed, :number, :type, :wagons

  # rubocop:disable Style/ClassVars
  # Рубокоп говорит:
  #   You have to be careful when setting a value for a class variable;
  #   if a class has been inherited, changing the value of a class variable also affects the inheriting classes.
  #   This means that it's almost always better to use a class instance variable instead.
  # Но в данном случае нам нужна именно переменная класса
  @@trains = {}
  # rubocop:enable Style/ClassVars

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @number = number
    validate_number
    validate!

    @speed = 0
    @wagons = []
    @@trains[number] = self
    assign_type
    register_instance
  end

  def accelerate
    if @speed + speed_step <= max_speed
      @speed += speed_step
    else
      @speed = max_speed
    end
  end

  def decelerate
    @speed -= speed_step if stopped?
  end

  def stopped?
    @speed.zero?
  end

  def add_wagon(wagon)
    raise ArgumentError, "Выберите вагон согласно типу поезда" unless valid_wagon_type?(wagon)
    return unless stopped?

    @wagons << wagon
  end

  # удаляет последний вагон из поезда
  def remove_wagon
    @wagons.pop if stopped?
  end

  def wagons_count
    @wagons.size
  end

  def free_space
    @wagons.sum(&:free_space)
  end

  def taken_space
    @wagons.sum(&:taken_space)
  end

  def human_readable_type
    "обычный"
  end

  # train.iterate_wagons { |wagon, wagon_number| ... }
  def iterate_wagons
    raise ArgumentError, "Необходимо передать блок" unless block_given?

    @wagons.each.with_index(1) { |wagon, wagon_number| yield wagon, wagon_number }
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

  # уведомляем станцию, что на нее прибыл поезд
  def add_self_to_station(station)
    station.add_train(self)
  end

  # уведомляем станцию, что поезд с нее убыл
  def remove_self_from_station(station)
    station.remove_train(self)
  end

  def validate_number
    add_error("Номер поезда должен соответствовать шаблону XXX[-][YY]") unless NUMBER_PATTERN.match?(number)
  end
end
