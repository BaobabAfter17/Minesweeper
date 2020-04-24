require_relative 'board.rb'

class Tile

    def initialize(board, position, bombed)
        @board = board # 9 * 9 full of tiles
        @position = position # [1, 3]
        @bombed = bombed    # boolean

        @flagged = false
        @revealed = false
    end

    def inspect

    end

    def reveal

    end

    def neighbors

    end

    def neighbor_bomb_count

    end


end