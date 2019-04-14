class PassengerTrain < Train
  # проверка что переданный относится к типу Пассажирский Вагон
  protected

  def assign_type
    @type = :passenger
  end
end
