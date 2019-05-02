class Round
  attr_reader :deck, :turns, :current_card,
    :number_correct, :discard_pile

  def initialize(deck)
    @deck = deck
    @turns = []
    @discard_pile = []
    @number_correct = 0
    @num_correct_by_category = Hash.new
    @num_cards_by_category = Hash.new
    set_first_card
  end

  def set_first_card
    if @deck.count_cards > 0
      @current_card = @deck.cards.shift
    else
      p "We don't have any cards!"
      @current_card = nil
    end
  end

  def take_turn(guess)
    this_turn = Turn.new(guess,@current_card)

    cur_cat = @current_card.category
    @num_correct_by_category[cur_cat] ||= 0
    @num_cards_by_category[cur_cat] ||= 0
    if this_turn.correct?
      @num_correct_by_category[cur_cat] += 1
      @number_correct += 1
    end
    @num_cards_by_category[cur_cat] += 1

    @discard_pile.push(@current_card)

    if @deck.count_cards > 0
      @current_card = deck.cards.shift
    else
      shuffle_cards
    end

    @turns.push(this_turn)
    this_turn
  end

  def shuffle_cards
    @discard_pile.shuffle!
    @deck = Deck.new(@discard_pile)
    set_first_card
    @discard_pile = []
  end

  def number_correct_by_category(category)
    #(@turns.select { |turn| turn.card.category == category && turn.correct? }).length
    @num_correct_by_category[category]
  end

  def percent_correct
    (@number_correct / @turns.length.to_f).round(2)
  end

  def number_turns_by_category(category)
    #(@turns.select { |turn| turn.card.category == category }).length
    @num_cards_by_category[category]
  end

  def percent_correct_by_category(category)
    (number_correct_by_category(category) / number_turns_by_category(category).to_f).round(2)
  end

  def get_all_categories
    @num_cards_by_category.keys
  end
end
