class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def count_cards
    @cards.length
  end

  def cards_in_category(category)
    category_list = @cards.select do |card|
      card.category == category
    end
  end
end
