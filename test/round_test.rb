require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/round'
require './lib/deck'
require './lib/turn'
require 'pry'

class RoundTest < Minitest::Test
  def setup
    @alaska_card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    @mars_card = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    @direction_card = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    @deck = Deck.new([@alaska_card, @mars_card, @direction_card])
    @round = Round.new(@deck)
  end

  def test_it_exists
    assert_instance_of Round, @round
  end

  def test_that_take_turn_returns_turn
    assert_instance_of Turn, @round.take_turn("Juneau")
  end

  def test_take_turn_updates_status
    @round.take_turn("Juneau")

    assert_equal @alaska_card, @round.deck.cards[0]
    assert_equal 1, @round.number_correct
    assert_equal 1, @round.turns.length
    assert_equal @mars_card, @round.current_card
  end

  def test_take_turn_with_incorrect_guess
    @round.take_turn("Anchorage")

    assert_equal @alaska_card, @round.deck.cards[0]
    assert_equal 0, @round.number_correct
    assert_equal 1, @round.turns.length
    assert_equal @mars_card, @round.current_card
  end

  def test_number_correct_by_category
    @round.take_turn("Juneau")
    @round.take_turn("Mars")
    @round.take_turn("Kanye")

    assert_equal 2, @round.number_correct
    assert_equal 1, @round.number_correct_by_category(:Geography)
    assert_equal 1, @round.number_correct_by_category(:STEM)
  end

  def test_percent_correct_and_percent_correct_by_category
    @round.take_turn("Juneau")
    @round.take_turn("Mars")
    @round.take_turn("Kanye")

    assert_equal 0.67, @round.percent_correct
    assert_equal 1.00, @round.percent_correct_by_category(:Geography)
    assert_equal 0.50, @round.percent_correct_by_category(:STEM)
  end

  def test_shuffle_method
    @round.take_turn("Juneau")
    @round.take_turn("Mars")
    @round.take_turn("Kanye")

    assert_equal 3, @round.deck.count_cards
    assert_instance_of Card, @round.current_card
  end
end
