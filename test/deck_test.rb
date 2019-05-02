require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/turn'
require './lib/deck'

class DeckTest < Minitest::Test
  def setup
    @alaska_card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    @mars_card = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    @direction_card = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    @deck = Deck.new([@alaska_card, @mars_card, @direction_card])
  end

  def test_it_exists
    assert_instance_of Deck, @deck
  end

  def test_it_has_a_card
    assert_instance_of Card, @deck.cards[0]
  end

  def test_card_matches
    assert_equal @alaska_card, @deck.cards[0]
  end

  def test_all_cards_match
    assert_equal @alaska_card, @deck.cards[0]
    assert_equal @mars_card, @deck.cards[1]
    assert_equal @direction_card, @deck.cards[2]
  end

  def test_count_cards
    assert_equal 3, @deck.count_cards
  end

  def test_cards_in_category
    assert_equal 1, @deck.cards_in_category(:Geography).length
    assert_equal @alaska_card, @deck.cards_in_category(:Geography)[0]
    assert_equal 2, @deck.cards_in_category(:STEM).length
    assert_equal @mars_card, @deck.cards_in_category(:STEM)[0]
    assert_equal @direction_card, @deck.cards_in_category(:STEM)[1]
  end
end
