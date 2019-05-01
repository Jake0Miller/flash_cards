class Round
  attr_reader :deck, :turns, :current_card, :number_correct, :discard_pile

  def initialize(deck)
    @deck = deck
    @turns = []
    @discard_pile = []
    @number_correct = 0
    set_first_card
  end

  def set_first_card
    if @deck.count > 0
      @current_card = deck.cards.shift
    else
      p "We're out of cards!"
      @current_card = nil
    end
  end

  def take_turn(guess)
    this_turn = Turn.new(guess,@current_card)
    if this_turn.correct?
      @number_correct += 1
    end
    @discard_pile.push(@current_card)
    @current_card = deck.cards.shift
    @turns.push(this_turn)
    this_turn
  end

  def number_correct_by_category(category)
    category_list = @turns.select do |turn|
      turn.card.category == category and turn.correct?
    end
    category_list.length
  end

  def percent_correct
    @number_correct / @turns.length.to_f
  end

  def percent_correct_by_category

  end
end
