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
        # if unexplored / unrealved
            # show * if not flagged
            # show F if flagged
        # if explored / revealed
            # show _ if not neighbor to any bomb
            # show num if neighor to any bomb(s)
    end

    private
    attr_writer :board

end

if $PROGRAM_NAME == __FILE__
    b = Board.new
    b.board.each do |row|
        row.each do |ele|
            print "#{ele.bombed} "
        end
        puts
    end
    t = b[[2,3]]
    p t.neighbor_bomb_count
end