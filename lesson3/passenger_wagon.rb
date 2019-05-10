# Добавить атрибут общего кол-ва мест (задается при создании вагона)
# Добавить метод, который "занимает места" в вагоне (по одному за раз)
# Добавить метод, который возвращает кол-во занятых мест в вагоне
# Добавить метод, возвращающий кол-во свободных мест в вагоне.
class PassengerWagon < Wagon
  
  DEFAULT_SEATS_COUNT = 54
  attr_reader :taken_seats_count

  def initialize(total_seats_count: DEFAULT_SEATS_COUNT)
    super()
    @total_seats_count = total_seats_count || DEFAULT_SEATS_COUNT
    @taken_seats_count = 0
  end
  
  def take_seat
    return if free_seats_count <= 0 
    @taken_seats_count += 1
  end

  def free_seats_count
    @total_seats_count - @taken_seats_count
  end

  def human_readable_type
    "пассажирский"
  end

  protected

  def assign_type
    @type = :passenger
  end
end
