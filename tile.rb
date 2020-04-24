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
        "position: #{position}, bombed: #{bombed}, flagged: #{flagged}, revealed: #{revealed}"
    end

    def reveal
        self.revealed = true
    end

    def neighbors

    end

    def neighbor_bomb_count

    end

    private
    attr_accessor :revealed
    attr_reader :board, :position, :bombed, :flagged

end