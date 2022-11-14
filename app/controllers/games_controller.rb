require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def index
  end

  def new
    @@letters = (('A'..'Z').to_a * 2).sample(10)
    @letters = @@letters
  end

  def score
    @letters = @@letters
    @word = params[:word].upcase
    @message = ''
    # if word has letters not from @letters
    if !included?
      @message = "Sorry but #{@word} can't be built out of #{@letters.join(', ')}"
    # if word is not english word
    elsif !english_word?
      @message = "Sorry but #{@word} does not seem to be a valid English word..."
    # else is valid
    elsif included? && english_word?
      @message = "Congratulations! #{@word} is a valid English word!"
    end
  end

  def included?
    @word.split('').difference(@letters).empty?
  end

  def english_word?
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    dictionary_lewagon = URI.open(url).read
    dictionary = JSON.parse(dictionary_lewagon)
    dictionary[:found] == 'true'
  end
end
