require './lib/card'
require './lib/round'
require './lib/deck'
require './lib/turn'
require './lib/card_generator'
require 'pry'

cards = CardGenerator.new("cards.txt").cards
deck = Deck.new(cards)
round = Round.new(deck)

def start(round)
  num_turns = round.deck.count_cards + 1
  puts "Welcome! You're playing with #{num_turns} cards."
  puts "-------------------------------------------------"

  draw_all_cards(num_turns, round)

  puts "****** Game over! ******"
  display_number_correct(num_turns, round)
  display_correct_by_category(num_turns, round)

  play_again?(round)
end

def play_again?(round)
  puts "Shuffle cards and play again? Yes\ No"
  answer = gets.chomp
  if answer != "Yes"
    exit
  else
    start(round)
  end
end

def display_correct_by_category(num_turns, round)
  round.get_all_categories.each do |category|
    puts "#{category} - #{convert_percent_to_display(round.percent_correct_by_category(category))}% correct"
  end
end

def display_number_correct(num_turns, round)
  num_correct = round.number_correct
  if num_correct == 1
    puts "You had 1 correct guess out of #{num_turns} for a total score of #{convert_percent_to_display(round.percent_correct)}%."
  else
    puts "You had #{num_correct} correct guesses out of #{num_turns} for a total score of #{convert_percent_to_display(round.percent_correct)}%."
  end
end

def convert_percent_to_display(num)
  (num*100).to_i
end

def display_question(num_turns, round)
  puts "This is card number #{round.turns.length + 1} out of #{num_turns}."
  puts "Question: #{round.current_card.question}"
end

def get_user_answer
  puts "What is the answer?"
  gets.chomp
end

def draw_all_cards(num_turns, round)
  for i in 1..num_turns do
    display_question(num_turns, round)
    cur_turn = round.take_turn(get_user_answer)
    puts cur_turn.feedback
  end
end

start(round)
