class Computer
    attr_accessor :word, :hidden_word, :guesses, :attemptleft
    def initialize
        @word = nil
        @hidden_word = nil
        @guesses = []
        @attemptleft = 6
    end
end