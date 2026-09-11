
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
    if self.is_comp
      puts "#{self.name} is choosing..."
      sleep 2
      return Random.rand(9) + 1
    else
      begin
        print "#{self.name}, choose a block to claim (1-9): "
        sel_block = gets.chomp.to_i
        if (1..9).cover? sel_block
          return sel_block
        else
          raise
        end
      rescue
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