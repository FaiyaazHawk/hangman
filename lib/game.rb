require './player.rb'
require './computer.rb'
require './display.rb'
require '../5desk.txt'

class Game
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