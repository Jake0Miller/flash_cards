class Round
  attr_reader :deck, :turns, :current_card, :number_correct

  def initialize(deck)
    @deck = deck
    @turns = []
    if deck.cards.length > 0
      @current_card = deck.cards[0]
    else
      @current_card = nil
    end
    @number_correct = 0
  end

  def take_turn(guess)

  end

  def number_correct_by_category(category)
    category_list = @turns.select do |turn|
      turn.card.category == category
    end
    category_list.length
  end

  def percent_correct
    @number_correct / @turns.length.to_f
  end

  def percent_correct_by_category

  end
end
