
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
    "Created a parking lot with #{parking_lot_number} slots"
  end

  def park_car(params)
    return "Sorry, parking lot is full" if @open_slots.empty? || @open_slots.count == open_slots_count
    available_slot = @open_slots.min
    @parked_slots.merge!({available_slot => {number: params[:number], color: params[:color]}})
    @open_slots.delete(available_slot)
    "Allocated slot number: #{available_slot}"
  end

  def leave(slot_number)
    if @parked_slots.key?(slot_number)
      @open_slots.push(slot_number)
      @parked_slots.delete(slot_number)
      "Slot number #{slot_number} is free"
    else
      "Sorry, Parking slot #{slot_number} is not present"
    end
  end

  def status
    return p "Parking is Empty" if @parked_slots.empty?
    puts "\nSlot No.\tRegistration No \tColor"
    @parked_slots.each do |slot_number, values|
      puts "#{slot_number}\t\t#{values[:number]}\t\t#{values[:color]}"
    end
  end

  def get_register_number_for_color(color)
    number = []
    @parked_slots.map { |key, values| number << values[:number] if values[:color] == color }
    return "Not found" if number.empty?
    number.join(", ")
  end

  def get_slot_for_color(color)
    get_slot = []
    @parked_slots.map { |key, values| get_slot << key if values[:color] == color  }
    return "Not found" if get_slot.empty?
    get_slot.join(", ")
  end

  def get_slot_for_register_number(number)
    get_slot = []
    @parked_slots.map { |key, values| get_slot << key if values[:number] == number }
    return "Not found" if get_slot.empty?
    get_slot.join(", ")
  end
end