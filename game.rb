require_relative "board.rb"
require "yaml"

class Game
    attr_reader :board

    def initialize
        @board = Board.new
    end

    def run
        play_round until self.win? || self.game_over?
        puts "Congratulation! You WIN!" if self.win?
        puts "Sorry, you lose.." if self.game_over?

    end

    def play_round
        board.render
        command = get_command
        case command
        when 'r'
            position = get_position
            board.reveal(position)
        when 'f'
            position = get_position
            board.change_flag_at(position)
        when 's'
            self.save_game
        when 'l'
            self.load_game
        end

    end

    def get_position
        puts "Enter position like '3 4': "
        print ">"
        position = []
        until self.valid_position?(position)
            position = gets.chomp.split.map {|char| Integer(char)}
            if !self.valid_position?(position)
                puts "Invalid position, enter again:"
                print ">"
            end
        end
        position
    end

    def valid_position?(position)
        return false if position.length != 2
        size = board.size
        position.all? {|index| index.between?(0, size - 1)}
    end

    def get_command
        puts "Type 'r' to reveal or 'f' to flag or unflagg:"
        puts "Type 's' to save game or 'l' to load game:"
        print ">"
        commands = ['r', 'f', 's', 'l']
        command = ''

        until commands.include?(command)
            command = gets.chomp
            if !commands.include?(command)
                puts "Invalid command. Make sure to type 'r' or 'f' or 's' or 'l':"
                print ">"
            end
        end
        command
    end

    def win?
        board.win?
    end

    def game_over?
        board.game_over
    end

    def save_game
        puts "Enter name for your save: "
        print ">"
        file_name = gets.chomp
        whole_file_name = file_name + ".yml"
        File.open(whole_file_name, "w") { |file| file.write(board.to_yaml) }
        puts "Save sucessful!"
    end

    def load_game
        puts "Enter name of your save: "
        print ">"
        file_name = gets.chomp
        whole_file_name = file_name + ".yml"
        new_board = YAML.load(File.read(whole_file_name))
        self.board = new_board
        puts "Load sucessful!"
    end

    private
    attr_writer :board

end

if $PROGRAM_NAME == __FILE__
    g = Game.new
    g.run
end
