class Turn
  attr_reader :guess, :card

  def initialize(guess, card)
    @guess = guess
    @card = card
  end

  def correct?
    @card.answer == @guess
  end

  def feedback
    if self.correct?
      "Correct!"
    else
      "Incorrect."
    end
  end
end
