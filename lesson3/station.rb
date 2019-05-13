# frozen_string_literal: true

require_relative "instance_counter"
require_relative "errors_list"

# Станция
# 1. Имеет название, которое указывается при ее создании
# 2. Может принимать поезда (по одному за раз)
# 3. Может возвращать список всех поездов на станции, находящиеся в текущий момент
# 4. Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# 5. Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
# 6. В классе Station (жд станция) создать метод класса all, который возвращает все станции (объекты),
#    созданные на данный момент
# 7. написать метод, который принимает блок и проходит по всем поездам на станции, передавая каждый поезд в блок.
class Station
  include InstanceCounter
  include ErrorsList

  NAME_PATTERN = /^[а-яa-z]/i.freeze
  NAME_MIN_LENGTH = 3

  attr_reader :trains, :name

  def initialize(name)
    # name переводим в string, чтобы дополнительно не проверять на nil
    @name = name.to_s
    validate_name
    validate!

    @trains = []
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  # Кол-во поездов указанного типа на станции
  def count_trains_by_type(type)
    @trains.count { |train| train.type == type }
  end

  # Отправка поезда:
  # Убираем поезд из списка поездов на станции
  # Возвращаем отправленный поезд или nil, если указанный поезд не найден в списке
  def remove_train(train)
    @trains.delete(train)
  end

  ##
  # station.iterate_trains { |train| puts train.number }
  def iterate_trains
    raise ArgumentError, "Необходимо передать блок" unless block_given?

    @trains.each do |train|
      yield train
    end
  end

  protected

  def validate_name
    # имя не должно быть пустым
    # должно начинаться с буквы и содержать не менее 3х символов
    add_error("Название станции должно содержать не менее трех символов") if name.length < NAME_MIN_LENGTH
    add_error("Название станции должно начинаться с буквы") unless NAME_PATTERN.match?(name)
  end
end
