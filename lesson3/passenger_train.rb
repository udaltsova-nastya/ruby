class PassengerTrain < Train
  # первый вариант решения
  # def free_seats_count
  #   free_seats_count = 0
  #   @wagons.each do |wagon|
  #     free_seats_count += wagon.free_seats_count
  #   end
  #   free_seats_count
  # end

  # второй вариант решения
  # def free_seats_count
  #  @wagons.sum { |wagon| wagon.free_seats_count }
  # end

  # третий вариант
  def free_seats_count
    @wagons.sum(&:free_seats_count)
  end

  def taken_seats_count
    @wagons.sum(&:taken_seats_count)
  end

  def human_readable_type
    "пассажирский"
  end

  protected

  def assign_type
    @type = :passenger
  end
end
