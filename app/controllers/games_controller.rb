require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10){ ('A'..'Z').to_a.sample }.join(' ')
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    @included = included?(@word, @letters)
    @englishword = englishword?(@word)
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def englishword?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end


end
