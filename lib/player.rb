# frozen_string_literal: true

class Player
  attr_accessor :letter, :win_status

  def initialize
    @letter = nil
    @win_status = nil
  end
end
