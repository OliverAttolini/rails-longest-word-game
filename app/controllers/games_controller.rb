require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) {('A' .. 'Z').to_a.sample}
  end
  def score
    @word = params[:word]
    letters = params[:grid]
    if contains_letters(@word.upcase, letters)
      if eng_word_check?(@word)
        @answer = "Congratulations! Your word #{@word.upcase} is a valid english word!"
      else
        @answer = "Your word #{@word.upcase} is not an english word!"
      end
    else
      @answer = "Your word #{@word.upcase} is not computable with the given letters!"
    end
  end
end

def contains_letters(attempt, grid)
  attempt.chars.all? { |letter| attempt.count(letter) <= grid.count(letter) }
end

def eng_word_check?(attempt)
  url = "https://dictionary.lewagon.com/#{attempt}"
  user_serialized = URI.open(url).read
  user = JSON.parse(user_serialized)
  return user["found"]
end
