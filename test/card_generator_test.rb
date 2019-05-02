require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/card_generator'
require 'pry'

class CardGeneratorTest < Minitest::Test
  def setup
    @card_gen = CardGenerator.new("cards.txt")
    @alaska_card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
  end

  def test_it_exists
    assert_instance_of CardGenerator, @card_gen
  end

  def test_it_creates_cards
    refute @card_gen.cards.empty?
    assert_instance_of Card, @card_gen.cards[0]
  end

  def test_creates_card_question
    assert_equal @alaska_card.question, @card_gen.cards[0].question
  end

  def test_creates_card_answer
    assert_equal @alaska_card.answer, @card_gen.cards[0].answer
  end

  def test_creates_card_category
    assert_equal @alaska_card.category, @card_gen.cards[0].category
  end
end
