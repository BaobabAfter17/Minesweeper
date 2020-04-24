require_relative 'board.rb'

class Tile
    attr_reader :bombed
    attr_accessor :revealed, :flagged


    def initialize(board, position, bombed)
        @board = board # 9 * 9 full of tiles
        @position = position # [1, 3]
        @bombed = bombed    # boolean

        @flagged = false
        @revealed = false
    end

    def inspect
        "position: #{position}, bombed: #{bombed}, flagged: #{flagged}, revealed: #{revealed}"
    end

    def neighbors
        neighbors = []
        current_row, current_col = position
        (current_row - 1..current_row + 1).each do |row|
            (current_col - 1..current_col + 1).each do |col|
                if self.valid_position?(row, col) && [row, col] != position
                    neighbors << board[row][col]
                end
            end
        end
        neighbors
    end
    
    def valid_position?(row, col)
        side = board.length
        row.between?(0, side) && col.between?(0, side)
    end

    def neighbor_bomb_count
        neighbors = self.neighbors
        neighbors.count {|neighbor| neighbor.bombed}
    end

    def to_mark
        # if unexplored / unrealved
            # show * if not flagged
            # show F if flagged
        # if explored / revealed
            # show _ if not neighbor to any bomb
            # show num if neighor to any bomb(s)
        return '*' if !revealed && !flagged
        return 'F' if !revealed && flagged

        neighbor_bomb_count = self.neighbor_bomb_count
        return '_' if revealed && neighbor_bomb_count == 0
        return neighbor_bomb_count.to_s if revealed && neighbor_bomb_count != 0
    end

    private
    attr_reader :board, :position

end