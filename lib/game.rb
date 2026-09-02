require_relative "board"
require_relative "player"

class Game

  def initialize
    @LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    @player_1 = player_setup("X")
    @player_2 = player_setup("O")
    @board = Board.new
  end

  def player_setup(x_o)
    name = "Player '#{x_o}'"
    type = "human"
    print "Enter name for #{name}, or type 'C' for computer: "
    input = gets.chomp
    case input
    when "c", "C"
      name = "Comp '#{x_o}'"
      type = "computer"
    when ""

    else
      name = input
    end

    Player.new(name, type, x_o)
  end

  def play
    (@board.grid_size ** 2).times do |i|
      @board.draw
      begin
        print "choose a block to claim (1-9): "
        sel_block = gets.chomp.to_i
        if (1..9).cover? sel_block
          puts "good"
        else
          raise
        end
      rescue
        print "\e[1F\e[2K"
        retry
      else

      end
    end
  end
end