require "colorize"

# The game board grid
class Board
  attr_reader :grid_size

  def initialize(player1, player2)
    @grid_size = 3
    @player1 = player1
    @player2 = player2
  end

  def draw
    grid = "\n"
    @grid_size.times do |y|
      @grid_size.times do |x|
        grid << draw_box(x, y)
        grid << if x < @grid_size - 1
                  "|".white
                else
                  "\n"
                end
      end
      grid << if y < @grid_size - 1
                horizonal_draw.white
              else
                "\n"
              end
    end
    puts grid
  end

  private

  def horizonal_draw
    str = ""
    @grid_size.times do |i|
      str << "---"
      str << if i < @grid_size - 1
               "+"
             else
               "\n"
             end
    end
    str
  end

  def draw_box(x, y)
    block_num = x + (y * @grid_size) + 1

    if @player1.claimed_blocks.include? block_num
      " #{@player1.x_o} ".black.on_light_magenta
    elsif @player2.claimed_blocks.include? block_num
      " #{@player2.x_o} ".black.on_cyan
    else
      " #{block_num} "
    end
  end
end
