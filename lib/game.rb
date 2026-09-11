require_relative "board"
require_relative "player"

class Game

  def initialize
    @LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    @player_1 = player_setup("X")
    @player_2 = player_setup("O")
    @board = Board.new(@player_1, @player_2)
  end

  def player_setup(x_o)
    name = "Player '#{x_o}'"
    is_comp = false
    print "Enter name for #{name}, or type 'C' for computer: "
    input = gets.chomp
    case input
    when "c", "C"
      name = "Comp '#{x_o}'"
      is_comp = true
    when ""

    else
      name = input
    end
    Player.new(name, is_comp, x_o)
  end

  def play
    (@board.grid_size ** 2).times do |i|
      sel_block = 0
      @board.draw
      if i.even?
        curr_player = @player_1
      else
        curr_player = @player_2
      end
      loop do
        sel_block = curr_player.choose_block
        break if not [@player_1.claimed_blocks, @player_2.claimed_blocks].any? { |arr| arr.include? sel_block}
        puts "Block #{sel_block} is already taken" if not curr_player.is_comp
      end
      puts "#{curr_player.name} chooses block #{sel_block}"
      curr_player.claimed_blocks << sel_block
      if i >= (@board.grid_size - 1) && player_won?(curr_player)
        game_won(curr_player)
        break
      end
      game_tied if i >= (@board.grid_size ** 2) - 1
    end
    puts get_score
    play_agian if new_game?
  end

  def play_agian
    @player_1.reset_blocks
    @player_2.reset_blocks
    play
  end

  def new_game?
    begin
      print "New Game? (Y/n): "
      case gets.chomp
      when "y", "Y", ""
        return true
      when "n", "N"
        return false
      else
        raise
      end
    rescue
      print "\e[1F\e[2K"
      retry
    end
  end

  def player_won?(player)
    @LINES.any? { |a| (a - player.claimed_blocks).empty?}
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

  def get_score
    "Current score:\n#{@player_1}\n#{@player_2}\n"
  end

end