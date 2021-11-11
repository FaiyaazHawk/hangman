module Display
    
    def welcome
        puts "Hi there, Let's play Hangman"
    end

    def select_msg
        puts "Would you like to play a new game or load a previous game /nFor new game, enter 'N'. For Load, enter 'L'"
    end

    def rules
        <<~HEREDOC
            This is a 1 player game against the computer
            The computer will select a 5-7 letter long word. The player has to guess the word a letter at a time.
            The player will have 10 chances incase of an incorrect guess.
            With each correct guess, the correct letter will be displayed
            EX: _ _ _ _ (Ruby). If the guess is 'b', it will update to show _ _ b _
            At any point, instead of a guess, if the player types in "save", the game will be saved for later play.
        HEREDOC
    end

    def show_guess
        puts "Letter guessed #{@player.letter}. #{@computer.hidden_word.join(" ")} Previous letters#{@computer.guesses} Chances: #{@computer.attemptleft}"
    end
end