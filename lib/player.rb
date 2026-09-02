
class Player
  attr_reader :name, :type, :x_o, :score, :claimed_blocks

  def initialize(name, type, x_o)
    @name = name
    @type = type
    @x_o = x_o
    @score = 0
    @claimed_blocks = []
  end

  def to_s

    "#{name}\n
    #{type}\n
    #{x_o}\n
    #{score}\n
    #{claimed_blocks}\n\n"
  end
end