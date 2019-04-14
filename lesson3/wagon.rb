class Wagon
  attr_reader :type

  def initialize
    assign_type 
  end

  protected

  def assign_type
    @type = :standard
  end
end
