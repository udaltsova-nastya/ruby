class CargoTrain < Train
  def free_volume
    @wagons.sum(&:free_volume)
  end

  def taken_volume
    @wagons.sum(&:taken_volume)
  end

  def human_readable_type
    "грузовой"
  end

  protected

  def assign_type
    @type = :cargo
  end
end
