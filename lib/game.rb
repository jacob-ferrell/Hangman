require 'yaml'

class Game

  @@dictionary = File.readlines('google-10000-english-no-swears.txt')
  def initialize(save={})  #word=get_word, guesses_remaining=8, letters_used=[[],[]], progress='_'*word.length)
    @end_game = false
    @word = save['word'] || get_word
    @guesses_remaining = save['guesses_remaining'] || 8
    @letters_used = save['letters_used'] || [[],[]]
    @progress = save['progress'] || ('_' * @word.length).chars
    play_game 

  end

  def get_word
    word_pool = @@dictionary.map(&:chomp).select { |word| (5..12).to_a.include?(word.length) }
    word_pool[rand(0...(word_pool.length))]
  end

  def play_game
    
    while !game_over && !@end_game
      display
      get_guess
    end

    play_again if !@end_game
  end


  def display
    
    puts "\n\n#{'-' * 40}\n\nIncorrect guesses remaining: #{@guesses_remaining}"
    puts "\n          #{@progress.join(' ')}        Correct letters guessed: #{@letters_used[0]}     Incorrect letters guessed: #{@letters_used[1]}"
    
  end

  def get_guess
    puts "\n\nEnter a letter to make your next guess, or press 3 to save:"
    guess = gets.chomp.downcase[0]
    if guess == '3'
      return save_game
    elsif (/[a-z]/ =~ guess).nil?
      invalid_guess 
    end
    @word.include?(guess) ? correct_guess(guess) : incorrect_guess(guess)
  end

  def correct_guess(guess)
    puts "\nYour guess was correct!"
    @letters_used[0].push(guess)
    @word.chars.each_with_index do |char, i| 
      char == guess ? @progress[i] = char : []
  end
end

  def incorrect_guess(guess)
    puts "\nYour guess was incorrect!"
    @letters_used[1].push(guess)
    @guesses_remaining -= 1
  end

  def invalid_guess
    puts "\nInvalid guess."
    get_guess
  end

  def save_game
    @end_game = true
    game_data = {
      'word'=>@word,
      'guesses_remaining'=>@guesses_remaining,
      'letters_used'=>@letters_used,
      'progress'=>@progress
    }
    
    puts "\nEnter a name for your save: "
    Dir.mkdir('saves') unless Dir.exist?('saves')
    name = gets.chomp
    filename = "saves/#{name}.yml"
    File.open(filename, 'w') { |file| file.write game_data.to_yaml }
    File.exist?(filename) if puts "\nGame successfully saved!"
  end

  def game_over
    if @progress.join == @word
      sleep 1
      puts "\nCongratulations! You guessed the word!"
      return true
    elsif @guesses_remaining == 0
      sleep 1
      puts "\nYou've run out of guesses! Game over! The word was: #{@word}"
      return true
    end
    false
  end

  def play_again
    puts "Play again?  Y or N"
    choice = gets.chomp.downcase
    return choice == 'y' ? Game.new : []
  end
end
