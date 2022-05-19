require_relative 'game.rb'

class NewOrLoad

  def initialize
  puts "\n\n\n\n\nPlay a new game, or load an existing save?\n\nPress 1: New Game\nPress 2: Load Save"
      new_or_load
  end
  
  def new_or_load
      choice = gets.chomp
      choice == '1' ? Game.new : choice == '2' ? load_save : invalid_choice
    
  end
  
  def invalid_choice
    puts "\nInvalid Choice.  Enter 1 to play a new game, or 2 to load a save."
    new_or_load
  end   
  
  end
  NewOrLoad.new