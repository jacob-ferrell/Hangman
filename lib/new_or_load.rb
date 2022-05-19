require_relative 'game.rb'
require 'yaml'

class NewOrLoad

  def initialize
  puts "\n\n\n\n\nPlay a new game, or load an existing save?\n\nPress 1: New Game\nPress 2: Load Save"
      new_or_load
  end
  
  def new_or_load
      choice = gets.chomp
      choice == '1' ? Game.new : choice == '2' ? load_save : invalid_choice
    
  end

  def load_save
    save_name = get_save_name
    save = YAML.load_file("saves/#{save_name}.yml")
    Game.new(save)
  end
  
  def get_save_name
    puts "\nEnter the name of the save you wish to load: "
    save_name = gets.chomp
    if File.exist?("saves/#{save_name}.yml")
      save_name
    else
      puts "\nThat save file does not exist"
      get_save_name
    end   
  end

  def invalid_choice
    puts "\nInvalid Choice.  Enter 1 to play a new game, or 2 to load a save."
    new_or_load
  end   
  
  end
  NewOrLoad.new