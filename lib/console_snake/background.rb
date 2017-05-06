class ConsoleSnake::Background
  attr_accessor :direction, :position

  def initialize(console_vertical, console_horizontal)
    @board = console_vertical.times.map {|_| [0].cycle(console_horizontal / 2).to_a }
    @position = {x: console_horizontal / 4 - 1, y: console_vertical / 2 - 1}
    @direction = 'C'

    @board[@position[:y]][@position[:x] - 3] = 4
    @board[@position[:y]][@position[:x] - 2] = 3
    @board[@position[:y]][@position[:x] - 1] = 2
    @board[@position[:y]][@position[:x]] = 1
  end

  # NOTE A: up, B: down, C: right, D: left
  def turn!(next_direction)
    return if /A|B/ === @direction && /A|B/ === next_direction
    return if /C|D/ === @direction && /C|D/ === next_direction

    @direction = next_direction
  end

  def move!
    head_x, head_y = place_head

    case @direction
    when 'A'
      head_y -= 1
    when 'B'
      head_y += 1
    when 'C'
      head_x += 1
    when 'D'
      head_x -= 1
    end

    @board.each_with_index do |row, y|
      row.each_with_index do |p, x|
        @board[y][x] = p + 1 unless p == 0
        @board[y][x] = 0 if p == 4
      end
    end

    @position = {x: head_x, y: head_y}
    @board[head_y][head_x] = 1
  end

  def pretty_print
    print "\e[2J"
    print "\e[1;1H"

    @board.each do |row|
      row.each do |p|
        print p == 0 ? '  ' : '[]'
      end

      print "\n"
    end
  end

  private

  def place_head
    row_index = 0
    col_index = 0

    col_index = @board.index {|row| row_index = row.index(1) }

    [row_index, col_index]
  end
end
