# Car class
class Car
  attr_reader :reg_no, :color

  # Intialize the register number and color of the car
  def initialize(reg_no:, color:)
    @reg_no = reg_no
    @color = color
  end
end
