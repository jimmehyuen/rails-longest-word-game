require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = [*'A'..'Z'].to_a.sample(10)
  end

  # def generate_grid(grid_size)
  #   # TODO: generate random grid of letters
  #   @letters = Array.new(grid_size) { ('A'..'Z').to_a.sample }
  # end


  def score
    @user_word = params[:user_word]
    @letters = params[:letters]
    @result = included?(@letters, @user_word)
    @english = is_english?(@user_word)
  end

  def included?(guess, grid)
    # below line of code returns true/false
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def is_english?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
