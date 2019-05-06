class Round
  attr_reader :deck, :turns, :current_card, :number_correct

  def initialize(deck)
    @deck = deck
    @turns = []
    set_first_card
    @number_correct = 0
    @num_correct_by_category = Hash.new {0}
    @num_cards_by_category = Hash.new {0}
  end

  def set_first_card
    @current_card_number = 0
    @current_card = deck.cards[@current_card_number]
  end

  def take_turn(guess)
    cur_turn = Turn.new(guess,@current_card)
    cur_cat = @current_card.category

    if cur_turn.correct?
      @num_correct_by_category[cur_cat] += 1
      @number_correct += 1
    end

    @num_cards_by_category[cur_cat] += 1

    if @current_card_number < @deck.count_cards-1
      @current_card_number += 1
      @current_card = @deck.cards[@current_card_number]
    else
      shuffle_cards
    end

    @turns.push(cur_turn)
    cur_turn
  end

  def shuffle_cards
    @deck.cards.shuffle!
    set_first_card
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
    return 0 if number_turns_by_category(category) == 0
    (number_correct_by_category(category) / number_turns_by_category(category).to_f).round(2)
  end

  def get_all_categories
    @num_cards_by_category.keys
  end
end
