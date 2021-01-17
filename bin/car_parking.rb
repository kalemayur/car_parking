require 'tty-prompt'
require 'pastel'
require_relative 'parking'

prompt = TTY::Prompt.new
parking = Parking.new()

loop do
  cmd, *params = prompt.ask()&.split /\s/
  case cmd
  when "create_parking_lot"
    puts parking.create_parking_lot(params[0].to_i)
  when "park"
    puts parking.park_car({number: params[0].to_s, color: params[1].to_s})
  when "leave"
    puts parking.leave(params[0].to_i)
  when "status"
    parking.status
  when "registration_numbers_for_cars_with_colour"
    puts parking.get_register_number_for_color(params[0])
  when "slot_numbers_for_cars_with_colour"
    puts parking.get_slot_for_color(params[0])
  when "slot_number_for_registration_number"
    puts parking.get_slot_for_register_number(params[0])
  when "exit"
    break if prompt.yes?('Do you really want to exit?')
  else
    p "command not found"
  end
end


