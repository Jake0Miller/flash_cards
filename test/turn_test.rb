require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/turn'

class TurnTest < Minitest::Test
  def setup
    @card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    @turn = Turn.new("Juneau", @card)
  end

  def test_it_exists
    assert_instance_of Turn, @turn
  end

  def test_it_has_a_guess
    assert_instance_of String, @turn.guess
  end

  def test_it_has_a_card
    assert_instance_of Card, @turn.card
  end

  def test_guess_is_correct
    assert_equal "Juneau", @turn.guess
  end

  def test_guess_is_incorrect
    turn = Turn.new("Seattle", @card)

    #refute_equal "Juneau", turn.guess
    refute turn.correct?
  end

  def test_correct_guess_is_correct
    assert @turn.correct?
  end

  def test_incorrect_guess_is_incorrect
    turn = Turn.new("Seattle", @card)

    refute turn.correct?
  end

  def test_correct_guess_feedback
    assert_equal "Correct!", @turn.feedback
  end

  def test_incorrect_guess_is_incorrect
    turn = Turn.new("Seattle", @card)

    assert_equal "Incorrect.", turn.feedback
  end
end
