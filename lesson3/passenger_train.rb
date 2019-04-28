class PassengerTrain < Train
  # проверка что переданный относится к типу Пассажирский Вагон
  protected

  def assign_type
    @type = :passenger
  end

  def human_readable_type
    "пассажирский"
  end
end
