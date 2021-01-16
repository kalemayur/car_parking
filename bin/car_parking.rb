require 'tty-prompt'
require 'pastel'

class Parking
  attr_accessor :open_slots, :parked_slots, :open_slots_count

  def initialize
    @open_slots = []
    @parked_slots = {}
    @open_slots_count = 0
  end

  def create_parking_lot(parking_lot_number)
    @open_slots = Array.new(parking_lot_number) { |index| index + 1 }
    @parked_slots = {}
    return p "Created a parking lot with #{parking_lot_number} slots"
  end

  def park_car(params)
    return p "Sorry, parking lot is full" if @open_slots.empty? || @open_slots.count == open_slots_count
    available_slot = @open_slots.min
    @parked_slots.merge!({available_slot => {number: params[:number], color: params[:color]}})
    @open_slots.delete(available_slot)
    return p "Allocated slot number: #{available_slot}"
  end

  def leave(slot_number)
    if @parked_slots.key?(slot_number)
      @open_slots.push(slot_number)
      @parked_slots.delete(slot_number)
      return p "Slot number #{slot_number} is free"
    else
      return p "Sorry, Parking slot #{slot_number} is not present"
    end
  end

  def status
    return p "Parking is Empty" if @parked_slots.empty?
    puts "\n\nSlot No.\tRegistration No \tColor"
    @parked_slots.each do |slot_number, values|
      puts "#{slot_number}\t\t#{values[:number]}\t\t#{values[:color]}"
    end
  end

  def get_register_number_for_color(color)
    number = []
    @parked_slots.map { |key, values| number << values[:number] if values[:color] == color }
    return p "Slot is not available for color: #{color}" if number.empty?
    return p number
  end

  def get_slot_for_color(color)
    get_slot = []
    @parked_slots.map { |key, values| get_slot << key if values[:color] == color  }
    return p "Slot is not available for color: #{color}" if get_slot.empty?
    return p get_slot
  end

  def get_slot_for_register_number(number)
    get_slot = []
    @parked_slots.map { |key, values| get_slot << key if values[:number] == number }
    return p "Slot is not available for register number: #{number}" if get_slot.empty?
    return p get_slot
  end

  prompt = TTY::Prompt.new
  parking = Parking.new()

  loop do
    cmd, *params = prompt.ask()&.split /\s/
    case cmd
    when "create_parking_lot"
      parking.create_parking_lot(params[0].to_i)
    when "park"
      parking.park_car({number: params[0].to_s, color: params[1].to_s})
    when "leave"
      parking.leave(params[0].to_i)
    when "status"
      parking.status
    when "registration_numbers_for_cars_with_colour"
      parking.get_register_number_for_color(params[0])
    when "slot_numbers_for_cars_with_colour"
      parking.get_slot_for_color(params[0])
    when "slot_number_for_registration_number"
      parking.get_slot_for_register_number(params[0])
    when "exit"
      break if prompt.yes?('Do you really want to exit?')
    else
      p "command not found"
    end
  end
end


