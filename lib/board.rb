require "colorize"

class Board
  attr_reader :grid_size

  def initialize
    @grid_size = 3

  end

  def draw
    grid = "\n"

    @grid_size.times do |y|

      @grid_size.times do |x|

        grid += draw_box(x, y)

        if x < @grid_size - 1
          grid += "|"
        else
          grid += "\n"
        end

      end

      if y < @grid_size - 1
        grid += horizonal_draw
      else
        grid += "\n"
      end

    end

    puts grid

  end

  private

  def horizonal_draw
    str = ""

    @grid_size.times do |i|

      str += "---"

      if i < @grid_size - 1
        str += "+"
      else
        str += "\n"
      end

    end

    str

  end

  def draw_box(x, y)

    block_i = x + (y * @grid_size)
    " #{block_i + 1} "

  end

end