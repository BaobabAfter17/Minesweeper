require_relative 'tile.rb'

class Board
    # default board size 9 * 9, with 10 random mines

    def initialize
        @board=Array.new(9) {Array.new(9)}
        
    end

    def count_mines
        board.flatten.count {|boolean| boolean}
    end

    def populate_mines
        row = random(9)
        col = random(9)

    end

    def [](position)
        row, col = position
        board[row][col]
    end

    def []=(position, value)
        row, col = position
        board[row][col] = value
    end

    def render

    end

    private

    attr_accessor :board

end