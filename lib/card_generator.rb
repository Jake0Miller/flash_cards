require './lib/card'

class CardGenerator
  attr_reader :cards

  def initialize(file)
    @file = File.open(file, "r")

    alaska_card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    mars_card = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    direction_card = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    cards = [alaska_card, mars_card, direction_card]
    @cards = cards
  end
end
