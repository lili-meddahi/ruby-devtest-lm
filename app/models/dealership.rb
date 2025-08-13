class Dealership < ApplicationRecord
  has_many :cars, dependent: :destroy
  attr_accessor :make, :model, :year


  # allow user to add options to lists of make/model/year
  def add_detail(type, detail)
    case type
    when :make
      @makes << detail unless @makes.include?(detail)
    when :model
      @models << detail unless @models.include?(detail)
    when :year
      @years << detail unless @years.include?(detail)
    else
      puts "Invalid detail type. Use :make, :model, or :year."
    end
  end

  # remove a make/model/year from its respective list
  def rmv_detail(type, detail)
    case type
    when :make
      deleted_item = makes.delete(detail) 
      if deleted_item == detail
        puts "Deleted: #{deleted_item}" 
      else
        puts "Error, item not deleted."
      end
    when :model
      deleted_item = models.delete(detail) 
      if deleted_item == detail
        puts "Deleted: #{deleted_item}" 
      else
        puts "Error, item not deleted."
      end
    when :year
      deleted_item = years.delete(detail) 
      if deleted_item == detail
        puts "Deleted: #{deleted_item}" 
      else
        puts "Error, item not deleted."
      end
    else
      puts "Error, detail type not found."
    end
  end

  # add an instance of car to the dealership
  def add_car
    # user selects make/model/year of car they want to add
    makes = dealership.display_details_menu(:make)
    make = dealership.get_user_choice("Select a make:", makes)
    models = dealership.display_details_menu(:model)
    model = dealership.get_user_choice("Select a model:", models)
    years = dealership.display_details_menu(:year)
    year = dealership.get_user_choice("Select a year:", years)

    # if everything's dandy, the car gets created w/ appropriate details
    if @makes.include?(make) && @models.include?(model) && @years.include?(year)
        new_car = Car.new(make, model, year)
        @cars << new_car
        puts "Successfully created car: #{new_car}"
        new_car
      else
        # else, error
        puts "Error: One or more details needed. Please add them first."
        nil
    end
  end

  # method to remove a car
  def rmv_car
    cars.each_with_index do |car, index|
        puts "#{index + 1}. #{car}"
    car_to_delete = dealership.get_user_choice("Choose a car to delete: ", car)
    cars.delete(car_to_delete)
  end

  ################################
  # add_car supplemental methods #
  ################################

  # display options for make/model/year
  def display_details_menu(type)
    details = case type
      when :make
        @makes
      when :model
        @models
      when :year
        @years
      else
        []
      end
      puts "Available #{type.to_s.capitalize}s:"
      details.each_with_index do |detail, index|
        puts "#{index + 1}. #{detail}"
      end
      details
    end
  end
  
  # get user choice
  def get_user_choice(prompt, list)
    puts prompt
    choice = gets.chomp.to_i
    if choice > 0 && choice <= list.length
      list[choice - 1]
    else
      puts "Invalid choice. Please try again."
      get_user_choice(prompt, list)
    end
  end

  # list of cars
  def initialize
    @cars = []
  end

end  