# Parking lot class
class ParkingLot
  attr_reader :slots

  # Initialize the slots of the parking lot
  def initialize(size)
    @slots = Array.new(size)
  end

  # This shows the available slots in parking lot
  def available_slot
    slots.each_with_index do |slot, index|
      return index if slot.nil?
    end
    nil
  end

  # Park the car
  def park(car:, slot_num:)
    slots[slot_num] = car
  end

  # Leave the car
  def leave(slot_num)
    slots[slot_num] = nil
  end

  # Take color of the car and give register numbers of cars
  def get_reg_numbers_by_color(color)
    result = []
    slots.each do |slot|
      next unless slot
      result << slot.reg_no if slot.color == color
    end
    result
  end

  # Take register number of the car and give slot number of car
  def get_slot_num_by_reg_no(reg_no)
    slots.each_with_index do |slot, idx|
      next unless slot
      return (idx + 1).to_s if slot.reg_no == reg_no
    end
    nil
  end

  # Take color of the car and give slot numbers of cars
  def get_slot_num_by_color(color)
    result = []
    slots.each_with_index do |slot, idx|
      next unless slot
      result << (idx + 1).to_s if slot.color == color
    end
    result
  end
end
