require_relative 'tile.rb'

class Board
    attr_reader :board
    # default board size 9 * 9, with 10 random mines

    def initialize
        @board=Array.new(9) {Array.new(9, false)}
        self.populate_mines
        self.fill_up_board_with_tiles
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
            row = rand(9)
            col = rand(9)
            position = [row, col]
            self[position] = true
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
        puts "  0 1 2 3 4 5 6 7 8"
        board.each.with_index do |row, row_idx|
            print row_idx.to_s + " "
            row.each do |tile|
                print tile.to_mark + " "
            end
            puts
        end
    end

    private
    attr_writer :board

end

if $PROGRAM_NAME == __FILE__
    b = Board.new
    t = b[[2,3]]
    t.revealed = true
    t2 = b[[3,1]]
    t2.flagged = true
    t.flagged = true

    b.render

    # p t.neighbor_bomb_count
end