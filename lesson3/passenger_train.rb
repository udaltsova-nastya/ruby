class PassengerTrain < Train
  def human_readable_type
    "пассажирский"
  end

  protected

  def assign_type
    @type = :passenger
  end
end
