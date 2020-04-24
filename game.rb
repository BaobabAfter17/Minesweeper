require_relative "board.rb"

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
        position = get_position
        board.reveal(position) if command == 'r'
        board.change_flag_at(position) if command == 'f'
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
        print ">"
        command = ''
        until command == 'r' || command == 'f'
            command = gets.chomp
            if command != 'r' && command != 'f'
                puts "Invalid command. Make sure to type 'r' or 'f':"
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

end

if $PROGRAM_NAME == __FILE__
    g = Game.new
    g.run
end
