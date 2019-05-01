require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/round'
require './lib/deck'
require './lib/turn'
require 'pry'

class RoundTest < Minitest::Test
  def test_it_exists
    alaska_card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    mars_card = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    direction_card = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([alaska_card, mars_card, direction_card])
    round = Round.new(deck)

    assert_instance_of Round, round
  end

  def test_deck_exists
    alaska_card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    mars_card = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    direction_card = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([alaska_card, mars_card, direction_card])
    round = Round.new(deck)

    assert_instance_of Deck, round.deck
  end

  def test_cards
    alaska_card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    mars_card = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    direction_card = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    card_array = [alaska_card, mars_card, direction_card]
    deck = Deck.new(card_array)

    assert_instance_of Card, deck.cards[0]
    assert_instance_of Card, deck.cards[1]
    assert_instance_of Card, deck.cards[2]
    assert_equal 3, deck.cards.count
    assert_equal alaska_card, deck.cards[0]
    assert_equal mars_card, deck.cards[1]
    assert_equal direction_card, deck.cards[2]

    round = Round.new(deck)

    assert_instance_of Card, round.deck.cards[0]
    assert_instance_of Card, round.deck.cards[1]
    assert_equal 2, round.deck.cards.count
    assert_equal mars_card, round.deck.cards[0]
    assert_equal direction_card, round.deck.cards[1]
  end

  def test_that_take_turn_returns_turn
    alaska_card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    mars_card = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    direction_card = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([alaska_card, mars_card, direction_card])
    round = Round.new(deck)

    assert_instance_of Turn, round.take_turn("Juneau")
  end

  def test_take_turn_updates_status
    alaska_card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    mars_card = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    direction_card = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([alaska_card, mars_card, direction_card])
    round = Round.new(deck)
    round.take_turn("Juneau")

    assert_equal alaska_card, round.discard_pile[0]
    assert_equal 1, round.number_correct
    assert_equal 1, round.turns.length
    assert_equal mars_card, round.current_card
  end

  def test_take_turn_with_incorrect_guess
    alaska_card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    mars_card = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    direction_card = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([alaska_card, mars_card, direction_card])
    round = Round.new(deck)
    round.take_turn("Anchorage")

    assert_equal alaska_card, round.discard_pile[0]
    assert_equal 0, round.number_correct
    assert_equal 1, round.turns.length
    assert_equal mars_card, round.current_card
  end

  def test_correct_by_category
    alaska_card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    mars_card = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    direction_card = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    deck = Deck.new([alaska_card, mars_card, direction_card])
    round = Round.new(deck)
    round.take_turn("Juneau")
    round.take_turn("Mars")
    round.take_turn("Kanye")

    assert_equal 2, round.number_correct
    assert_equal 1, round.number_correct_by_category(:Geography)
    assert_equal 1, round.number_correct_by_category(:STEM)
  end
end
