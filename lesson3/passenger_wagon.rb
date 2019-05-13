# frozen_string_literal: true

# Добавить атрибут общего кол-ва мест (задается при создании вагона)
# Добавить метод, который "занимает места" в вагоне (по одному за раз)
# Добавить метод, который возвращает кол-во занятых мест в вагоне
# Добавить метод, возвращающий кол-во свободных мест в вагоне.
class PassengerWagon < Wagon
  DEFAULT_SEATS_COUNT = 54

  # Можно занять только по одному месту за раз
  def take_space
    super(1)
  end

  def human_readable_type
    "пассажирский"
  end

  protected

  def assign_type
    @type = :passenger
  end

  def default_total_space
    DEFAULT_SEATS_COUNT
  end
end
