require_relative "board"
require_relative "player"

# The game it's own object, could be useful if the future
class Game
  def initialize
    @LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    @player1 = player_setup("X")
    @player2 = player_setup("O")
    @board = Board.new(@player1, @player2)
  end

  def player_setup(x_o)
    is_comp = false
    print "Enter name for Player '#{x_o}', or type 'C' for computer: "
    input = gets.chomp
    case input
    when "c", "C"
      name = "Comp '#{x_o}'"
      is_comp = true
    when ""
      name = "Player '#{x_o}'"
    else
      name = input
    end
    Player.new(name, is_comp, x_o)
  end

  def play
    (@board.grid_size**2).times do |i|
      sel_block = 0
      @board.draw
      curr_player = if i.even?
                      @player1
                    else
                      @player2
                    end
      loop do
        sel_block = curr_player.choose_block
        break unless [@player1.claimed_blocks, @player2.claimed_blocks].any? { |arr| arr.include? sel_block }

        puts "Block #{sel_block} is already taken" unless curr_player.is_comp
      end
      puts "#{curr_player.name} chooses block #{sel_block}"
      curr_player.claimed_blocks << sel_block
      if i >= (@board.grid_size - 1) && player_won?(curr_player)
        game_won(curr_player)
        break
      end
      game_tied if i >= (@board.grid_size**2) - 1
    end
    puts score
    play_agian if new_game?
  end

  def play_agian
    @player1.reset_blocks
    @player2.reset_blocks
    play
  end

  def new_game?
    print "New Game? (Y/n): "
    case gets.chomp
    when "y", "Y", ""
      true
    when "n", "N"
      false
    else
      raise
    end
  rescue StandardError
    print "\e[1F\e[2K"
    retry
  end

  def player_won?(player)
    @LINES.any? { |a| (a - player.claimed_blocks).empty? }
  end

  def game_won(winner)
    @board.draw
    puts "#{winner.name} has won!\n"
    winner.increase_score
  end

  def game_tied
    @board.draw
    puts "It's a draw!\n"
  end

  def score
    "Current score:\n#{@player1}\n#{@player2}\n"
  end
end
