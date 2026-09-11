# Player objects to retain players' respective data throughout the game(s)
class Player
  attr_reader :name, :is_comp, :x_o, :score, :claimed_blocks

  def initialize(name, is_comp, x_o)
    @name = name
    @is_comp = is_comp
    @x_o = x_o
    @score = 0
    @claimed_blocks = []
  end

  def choose_block
    if is_comp
      puts "#{name} is choosing..."
      sleep 2
      Random.rand(1..9)
    else
      begin
        print "#{name}, choose a block to claim (1-9): "
        sel_block = gets.chomp.to_i
        return sel_block if (1..9).cover? sel_block

        raise
      rescue StandardError
        print "\e[1F\e[2K"
        retry
      end
    end
  end

  def increase_score
    @score += 1
  end

  def reset_blocks
    @claimed_blocks = []
  end

  def to_s
    "#{@name}:\t#{@score}"
  end
end
