class CargoTrain < Train
  def human_readable_type
    "грузовой"
  end

  protected

  def assign_type
    @type = :cargo
  end
end
