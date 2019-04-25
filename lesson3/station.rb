# Станция
# 1. Имеет название, которое указывается при ее создании
# 2. Может принимать поезда (по одному за раз)
# 3. Может возвращать список всех поездов на станции, находящиеся в текущий момент
# 4. Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# 5. Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
# 6. В классе Station (жд станция) создать метод класса all, который возвращает все станции (объекты), созданные на данный момент
require_relative 'instance_counter'

class Station

  include InstanceCounter

  attr_reader :trains, :name
 
  @@stations_count = 0

  def self.all
    @@stations_count
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations_count += 1
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
end
