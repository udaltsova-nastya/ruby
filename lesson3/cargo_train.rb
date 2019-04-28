class CargoTrain < Train

  protected

  def assign_type
    @type = :cargo
  end

  def human_readable_type
    "грузовой"
  end
end
