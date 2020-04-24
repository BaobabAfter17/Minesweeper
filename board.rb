require_relative 'tile.rb'
require 'colorize'

class Board
    attr_reader :board, :game_over
    # default board size 9 * 9, with 10 random mines

    def initialize
        @board=Array.new(9) {Array.new(9, false)}
        self.populate_mines
        self.fill_up_board_with_tiles
        @game_over = false
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

    def size
        board.length
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
        puts "  0 1 2 3 4 5 6 7 8".blue
        board.each.with_index do |row, row_idx|
            print row_idx.to_s.blue + " "
            row.each do |tile|
                print tile.to_mark + " "
            end
            puts
        end
    end

    def reveal(position)
        current_tile = self[position]

        return false if current_tile.flagged
        
        if current_tile.bombed
            self.game_over = true
        elsif current_tile.neighbor_bomb_count != 0
            current_tile.revealed = true
        else
            current_tile.revealed = true
            neighbors = current_tile.neighbors
            neighbors.each do |neighbor|
                if !neighbor.bombed && !neighbor.revealed
                    self.reveal(neighbor.position)
                end
            end
        end

    end

    def change_flag_at(position)
        current_tile = self[position]
        current_tile.flagged = !current_tile.flagged
    end

    def show_bombs
        # cheat method for testing only
        board.each do |row|
            row.each do |tile|
                if tile.bombed
                    print "B "
                else
                    print "_ "
                end
            end
            puts
        end
        
    end

    def win?
        return false if game_over
        board.all? do |row|
            row.all? do |tile|
                if tile.bombed
                    !tile.revealed
                else
                    tile.revealed
                end
            end
        end
    end

    private
    attr_writer :board, :game_over

end

if $PROGRAM_NAME == __FILE__
    b = Board.new
    # b.show_bombs
    # b.reveal([0,0])
    b.render
    b.change_flag_at([0,0])
    b.change_flag_at([8,8])
    b.render


    # p t.neighbor_bomb_count
end