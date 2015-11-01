class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  @@letter_list = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"] 
  
  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @word_with_guesses = '-' * word.length
    @lives = 7
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(char)
    if char == nil or char.length == 0 or char.class != String or not(@@letter_list.include? char.downcase)
      raise ArgumentError
    end
    char = char.downcase
    if @guesses.include? char or @wrong_guesses.include? char
      return false
    end
    if word.include? char
      word.length.times do |i|
        if word[i] == char
          @word_with_guesses[i] = char
        end
      end
      @guesses << char
    else
      @wrong_guesses << char
      @lives -= 1
    end
    return true
  end
  
  def check_win_or_lose
    if !@word_with_guesses.include? '-'
      return :win
    elsif @lives == 0
      return :lose
    else
      return :play
    end
  end

end
