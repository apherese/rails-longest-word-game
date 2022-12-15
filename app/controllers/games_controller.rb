require "open-uri"

class GamesController < ApplicationController
  def new
    chars = ('A'..'Z').to_a
    @letters = 10.times.map { chars.sample }
  end

  def score
    jason = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
    hash = JSON.parse(jason)
    is_english = hash["found"]
    @grid = params[:letters].downcase
    @try = params[:word].downcase
    if letter_in_grid(@try, @grid) && is_english
      @message = "Congratulations! \"#{@try}\" is a valid English word!"
    elsif is_english == false
      @message = "Sorry but \"#{@try}\" does not seem to be a valid English word"
    else
      @message = "Sorry but \"#{@try}\" can\'t be built from the grid \"#{@grid}\""
    end
  end

private

  def letter_in_grid(try, grid)
    try.split("").all? { |letter| grid.include?(letter) }
  end

end
