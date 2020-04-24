require_relative 'tile.rb'

class Board
    # default board size 9 * 9, with 10 random mines

    def initialize
        @board=Array.new(9) {Array.new(9)}
        
    end

    def fill_up_board_with_tiles
        side = board.length
        (0...side).each do |row|
            (0...side).each do |col|
                position = [row, col]
                bombed = self[position]
                new_tile = Tile.new(board, position, bombed)
                self[position] = new_tile
            end
        end
    end

    def count_mines
        board.flatten.count {|boolean| boolean}
    end

    def populate_mines
        until self.count_mines >=10
            row = random(9)
            col = random(9)
            board[[row, col]] = true
        end

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