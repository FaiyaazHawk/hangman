require './player.rb'
require './computer.rb'
require './display.rb'
require 'json'

class Game
    attr_accessor :player, :computer
    include Display
    def initialize
        @player = Player.new
        @computer = Computer.new
    end

    def play_game
        introduction
        game_select #choosing new game or loading old game
        gameplay
        conclusion
    end

    def introduction
        puts welcome
        puts rules
               
    end

    def new_game
        comp_pick_word
        @computer.hidden_word = Array.new(@computer.word.length) {|i| i = "_"}
    end

    def game_select
        puts select_msg
        choice = gets.chomp.downcase
        until choice == 'l' || choice == 'n'
            puts "Please make a proper selection"
            choice = gets.chomp.downcase
        end
        if choice == 'l'
            load_game
        elsif choice == 'n'
            new_game
        end
    end

    def comp_pick_word
        dictionary = File.read("../5desk.txt").split
        word = ''
        until word.length >= 5 && word.length <= 7
            word = dictionary.sample().downcase
        end
        @computer.word = word.split('')
        
    end

    def gameplay
        while @player.win_status == nil && @computer.attemptleft != 0
            puts "Please select a letter or enter 'save' to save the game"
            @player.letter = gets.chomp
            while @computer.guesses.include?(@player.letter)
                puts "You have already guessed #{@player.letter} Please select another letter"
                @player.letter = gets.chomp
            end
            if @player.letter == "save"
                save_game
            end
            update_hidden_word(@player.letter)

            show_guess
            if @computer.hidden_word == @computer.word
                @player.win_status = "Y"
            end 
            @computer.guesses << @player.letter
            
        end
    end

    def update_hidden_word(playerletter)
        matched_index = @computer.word.each_index.select {|index| @computer.word[index] == playerletter} #finds the index of letters that match playerletter in word
        if matched_index.length > 0 #if there are matches, update hidden word to show the letters
            matched_index.each do |index|
                @computer.hidden_word[index] = playerletter
            end
        else
            @computer.attemptleft -= 1
        end
    end

    def conclusion
        if @player.win_status == "Y"
            puts "Congrats!!! You guessed the word #{@computer.word.join}"
        else
            puts "Awww, You got hanged. The word was #{@computer.word.join}"
        end
    end

    def save_game
        File.open('saved_game.json', 'w') do |file|
            file.puts(game_to_json)
    end

    def game_to_json
        JSON.dump({
            word: @computer.word,
            hidden_word: @computer.hidden_word,
            guesses: @computer.guesses,
            attemptleft: @computer.attemptleft
        })
        
    end

    def game_from_json(saved_game)
        data = JSON.parse(File.read(saved_game))
        @computer = Computer.new(
            data['word'],
            data['hidden_word'],
            data['guesses'],
            data['attemptleft']
        )
    end

    def load_game
        return unless File.exist?(saved_game.json)

        File.open('saved_game.json', 'r') do |file|
            game_from_json(file)
        end
        File.delete('saved_game.json')    
        end
    end
   
end
test = Game.new
test.play_game
