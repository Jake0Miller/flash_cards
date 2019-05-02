require 'set'

class Round
  attr_reader :deck, :turns, :current_card,
    :number_correct, :discard_pile

  def initialize(deck)
    @deck = deck
    @turns = []
    @discard_pile = []
    @number_correct = 0
    @num_correct_and_num_cards_by_category = Hash.new
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
    if this_turn.correct?
      if @num_correct_and_num_cards_by_category[cur_cat] == nil
        @num_correct_and_num_cards_by_category[cur_cat] = [1,1]
      else
        @num_correct_and_num_cards_by_category[cur_cat][0] += 1
        @num_correct_and_num_cards_by_category[cur_cat][1] += 1
      end
      @number_correct += 1
    else
      if @num_correct_and_num_cards_by_category[cur_cat] == nil
        @num_correct_and_num_cards_by_category[cur_cat] = [0,1]
      else
        @num_correct_and_num_cards_by_category[cur_cat][1] += 1
      end
    end

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
    #category_list = @turns.select { |turn| turn.card.category == category && turn.correct? }
    #category_list.length
    @num_correct_and_num_cards_by_category[category][0]
  end

  def percent_correct
    (@number_correct / @turns.length.to_f).round(2)
  end

  def number_turns_by_category(category)
    #category_list = @turns.select do |turn|
      #turn.card.category == category
    #end
    #category_list.length
    @num_correct_and_num_cards_by_category[category][1]
  end

  def percent_correct_by_category(category)
    (number_correct_by_category(category) / number_turns_by_category(category).to_f).round(2)
  end

  def get_all_categories
    #categories = Set[]
    #@deck.cards.each do |card|
      #categories.add(card.category)
    #end
    #@discard_pile.each do |card|
      #categories.add(card.category)
    #end
    #categories
    @num_correct_and_num_cards_by_category.keys
  end
end
