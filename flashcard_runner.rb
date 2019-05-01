require './lib/card'
require './lib/round'
require './lib/deck'
require './lib/turn'
require 'pry'

alaska_card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
mars_card = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
direction_card = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
deck = Deck.new([alaska_card, mars_card, direction_card])
round = Round.new(deck)

def start(round)
  puts "Welcome! You're playing with 4 cards."
  puts "-------------------------------------------------"
  puts "This is card number #{round.turns.length + 1} out of #{round.deck.count_cards + 1}."
  puts "Question: #{round.current_card.question}"
end

start(round)
