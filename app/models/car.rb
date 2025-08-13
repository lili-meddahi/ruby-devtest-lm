class Car < ApplicationRecord
  belongs_to :dealership


  def initialize(make, model, year)
    @make = make
    @model = model
    @year = year
  end

  def make
    @make
  end

  def model
    @model
  end

  def year
    @year
  end

  def display_car
    puts "Make: #{make}, Model: #{model}, Year: #{year}"
  end
end