require "colorize"
#require_relative "game"
#require_relative "player"

class Board
  attr_reader :grid_size

  def initialize(p_1, p_2)
    @grid_size = 3
    @player_1 = p_1
    @player_2 = p_2
  end

  def draw
    grid = "\n"

    @grid_size.times do |y|

      @grid_size.times do |x|

        grid << draw_box(x, y)

        if x < @grid_size - 1
          grid << "|".white
        else
          grid << "\n"
        end

      end

      if y < @grid_size - 1
        grid << horizonal_draw.white
      else
        grid << "\n"
      end

    end

    puts grid

  end

  private

  def horizonal_draw
    str = ""

    @grid_size.times do |i|

      str << "---"

      if i < @grid_size - 1
        str << "+"
      else
        str << "\n"
      end

    end

    str

  end

  def draw_box(x, y)
    block_num = x + (y * @grid_size) + 1

    if @player_1.claimed_blocks.include? block_num
      " #{@player_1.x_o} ".black.on_light_magenta
    elsif @player_2.claimed_blocks.include? block_num
      " #{@player_2.x_o} ".black.on_cyan
    else
      " #{block_num} "
    end
  end

end