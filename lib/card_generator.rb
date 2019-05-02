require './lib/card'

class CardGenerator
  attr_reader :cards

  def initialize(file)
    @file = file
    @cards = create_cards
  end

  def create_cards
    cards = []
    IO.foreach(@file) do |line|
      split_line = line.chomp.split(',')
      split_line[2].gsub!(/ /, '_')
      cards << Card.new(split_line[0],split_line[1],split_line[2].to_sym)
    end
    cards
  end
end
