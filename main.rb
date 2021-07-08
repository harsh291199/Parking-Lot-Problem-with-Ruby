require_relative 'parking_lot'
require_relative 'car'

# Parking System class
class ParkingSystem
  attr_reader :parking_lot, :command_to_func_hash

  def initialize
    @command_to_func_hash = {
      create_parking_lot: method(:create_parking_lot),
      park: method(:park_process),
      leave: method(:leave_process),
      plate_numbers_for_cars_with_colour: method(:plate_numbers_by_color),
      slot_numbers_for_cars_with_colour: method(:slot_numbers_by_color),
      slot_number_for_registration_number:
      method(:slot_num_by_registration_number)
    }
  end

  # Create a parking lot of input size
  def create_parking_lot(size_in_str)
    size_in_int = size_in_str.to_i
    @parking_lot = ParkingLot.new(size_in_int)
    puts 'Created a parking lot with ' + size_in_str + ' slots'
  end

  # Park Process of car
  def park_process(reg_no:, color:, slot_num:)
    car = Car.new(reg_no: reg_no, color: color)
    parking_lot.park(car: car, slot_num: slot_num)
    puts 'Allocated slot number: ' + (slot_num + 1).to_s
  end

  # Leave process of car
  def leave_process(num_in_str)
    num_in_int = num_in_str.to_i
    parking_lot.leave num_in_int - 1
    puts 'Slot number ' + num_in_str + ' is free'
  end

  # Get plate number by color of car
  def plate_numbers_by_color(color)
    results = parking_lot.get_reg_numbers_by_color(color)
    results_in_str = results.join(', ')
    puts results_in_str
  end

  # Get Slot number by color of car
  def slot_numbers_by_color(color)
    results = parking_lot.get_slot_num_by_color(color)
    results_in_str = results.join(', ')
    puts results_in_str
  end

  # Get slot number by plate number(registration number)
  def slot_num_by_registration_number(reg_no)
    slot_num = parking_lot.get_slot_num_by_reg_no(reg_no)
    return 'Not found' unless slot_num

    puts slot_num.to_s
  end

  # Check if slot is free and if free then park the car
  def check_and_park(splitted_input)
    slot_num = parking_lot.available_slot
    if slot_num
      park_process(reg_no: splitted_input[1],
                   color: splitted_input[2],
                   slot_num: slot_num)
    else
      puts 'Sorry, parking lot is full'
    end
  end

  # Print the Information of car and it's slot number
  def print_table(slots)
    table_format = "Slot No.  |  Registration No  |  Colour\n"

    slots.each_with_index do |slot, id|
      next unless slot

      table_format += (id + 1).to_s + ' | ' + slot.reg_no + ' | ' + slot.color
      table_format += "\n"
    end

    print table_format
  end

  # Statement command
  def two_statement_command(input)
    command_to_func_hash[input[0].to_sym].call input[1]
  end

  # Parse the user input
  def parse_user_input(input)
    splitted_input = input.split
    if splitted_input.size == 1
      print_table parking_lot.slots
    elsif splitted_input.size == 2
      two_statement_command splitted_input
    elsif splitted_input.size == 3
      check_and_park splitted_input
    end
  end

  def run
    loop do
      # Get User input
      parse_user_input STDIN.gets.strip
    end
  end
end

object = ParkingSystem.new
object.run
