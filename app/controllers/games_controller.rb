require 'json'
require 'open-uri'

class GamesController < ApplicationController


  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    word = params[:word].upcase
    @score = 0
    arr = params[:grid].split("")
    @msg = ""

    url = "https://wagon-dictionary.herokuapp.com/#{word.downcase}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    if !user["found"]
      @msg = "This word is not an english word!"
    end

    word.split('').each do |letter|
      if arr.include?(letter)
        arr.delete_at(arr.index(letter))
        @score += 5
      else
        @msg = 'This word is not in the grid!'
      end
    end
  end

end
