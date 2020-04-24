require_relative "board.rb"

class Game
    attr_reader :board

    def initialize
        @board = Board.new
    end

    def run

    end

    def play_round

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

end
