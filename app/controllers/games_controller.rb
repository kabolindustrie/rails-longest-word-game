require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = ('A'..'Z').to_a
    @rand_word = Array.new(10) { @letters.sample }
  end

  def score
    @word = params[:word].downcase.split("")
    # @authenticity_token = params[:authenticity_token]
    @letters = params[:letters].downcase.split(" ")

    @english = @word.map do |w|
      @letters.count(w) == @word.count(w)
    end
    @english.uniq == [true]

    if @english.uniq == [true]
      if english_word?(params[:word])
        @result = "Congratulations! #{@result} is a valid English word!"
      else
        @result = "Sorry but #{@result} does not seem to be a valid English word..."
      end
    else
      @result = "Sorry but #{@result} can't be build out of #{@word}"
    end
  end

  private

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}").read
    JSON.parse(response)['found']
  end
end
