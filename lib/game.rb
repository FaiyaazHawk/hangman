require './player.rb'
require './computer.rb'
require './display.rb'


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
        @computer.word = word
        
    end
    
end
test = Game.new
test.comp_pick_word
p test