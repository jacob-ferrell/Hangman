class Game

  @@dictionary = File.readlines('google-10000-english-no-swears.txt')
  def initialize(word=get_word, guesses_remaining=8, letters_used=[[],[]], progress='_'*word.length)
    
    @word = word
    puts @word
    @guesses_remaining = guesses_remaining
    @letters_used = letters_used
    @progress = progress.chars
    play_game 

  end

  def get_word
    word_pool = @@dictionary.map(&:chomp).select { |word| (5..12).to_a.include?(word.length) }
    word_pool[rand(0...(word_pool.length))]
  end

  def play_game
    
    while !game_over
      display
      get_guess
    end
    play_again
  end


  def display
    
    puts "\n\n#{'-' * 40}\n\nIncorrect guesses remaining: #{@guesses_remaining}"
    puts "\n          #{@progress.join(' ')}        Letters used: #{@letters_used}"
    
  end

  def get_guess
    puts "\n\nEnter a letter to make your next guess:"
    guess = gets.chomp.downcase[0]
    invalid_guess if (/[a-z]/ =~ guess).nil?
    @word.include?(guess) ? correct_guess(guess) : incorrect_guess(guess)
  end

  def correct_guess(guess)
    puts "\nYour guess was correct!"
    @letters_used[0].push(guess)
    @word.chars.each_with_index do |char, i| 
      char == guess ? @progress[i] = char : []
  end
end

  def invalid_guess
    puts "\nInvalid guess."
    get_guess
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
