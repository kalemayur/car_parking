require 'spec_helper'
require_relative '../bin/parking'

describe Parking do
  parking = Parking.new()
  it 'should create parking lots' do
    expect(parking.create_parking_lot(6)).to eq "Created a parking lot with 6 slots"
  end

  it 'should park car on slot 1' do
    car_park_params = {number: "KA-01-P-333", color: "White"}
    expect(parking.park_car(car_park_params)).to eq "Allocated slot number: 1"
  end

  it 'should park car on slot 2' do
    car_park_params = {number: "KA-01-P-444", color: "Black"}
    expect(parking.park_car(car_park_params)).to eq "Allocated slot number: 2"
  end

  it 'should park car on slot 3' do
    car_park_params = {number: "KA-01-P-222", color: "Black"}
    expect(parking.park_car(car_park_params)).to eq "Allocated slot number: 3"
  end

  it 'should park car on slot 4' do
    car_park_params = {number: "KA-01-P-666", color: "Red"}
    expect(parking.park_car(car_park_params)).to eq "Allocated slot number: 4"
  end

  it 'should park car on slot 5' do
    car_park_params = {number: "KA-01-P-555", color: "Blue"}
    expect(parking.park_car(car_park_params)).to eq "Allocated slot number: 5"
  end

  it 'should park car on slot 6' do
    car_park_params = {number: "KA-01-P-111", color: "White"}
    expect(parking.park_car(car_park_params)).to eq "Allocated slot number: 6"
  end

  it 'should leave parking car on slot 4' do
    expect(parking.leave(4)).to eq "Slot number 4 is free"
  end

  it 'should leave parking car on slot 10' do
    expect(parking.leave(10)).to eq "Sorry, Parking slot 10 is not present"
  end

  it 'should park car on slot 4' do
    car_park_params = {number: "KA-01-P-0101", color: "White"}
    expect(parking.park_car(car_park_params)).to eq "Allocated slot number: 4"
  end

  it 'should return parking lot is full error ' do
    car_park_params = {number: "KA-01-P-0101", color: "White"}
    expect(parking.park_car(car_park_params)).to eq "Sorry, parking lot is full"
  end

  it 'should return register number for given color white' do
    expect(parking.get_register_number_for_color("White")).to eq "KA-01-P-333, KA-01-P-111, KA-01-P-0101"
  end

  it 'should return slot number for given color white' do
    expect(parking.get_slot_for_color("White")).to eq "1, 6, 4"
  end

  it 'should return slot number for given register number' do
    expect(parking.get_slot_for_register_number("KA-01-P-333")).to eq "1"
  end

  it 'should return slot number for given register number' do
    expect(parking.get_slot_for_register_number("KA-01-P-444")).to eq "2"
  end

  it 'should return msg if slot number is not available for given register number' do
    color = "GREEN"
    expect(parking.get_slot_for_color(color)).to eq "Not found"
  end

  it 'should return msg if slot number is not available for given register number' do
    color = "GREEN"
    expect(parking.get_register_number_for_color(color)).to eq "Not found"
  end

  it 'should return msg if slot number is not available for given register number' do
    number = "KA-01-P-44445"
    expect(parking.get_slot_for_register_number(number)).to eq "Not found"
  end


  it 'should return status' do
    result = {1=>{:color=>"White", :number=>"KA-01-P-333"},
              2=>{:color=>"Black", :number=>"KA-01-P-444"},
              3=>{:color=>"Black", :number=>"KA-01-P-222"},
              4=>{:color=>"White", :number=>"KA-01-P-0101"},
              5 => {:color=>"Blue", :number=>"KA-01-P-555"},
              6=>{:color=>"White", :number=>"KA-01-P-111"}
            }
    expect(parking.status).to eq result
  end

end
