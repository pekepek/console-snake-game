require 'tty'
require 'console_snake/version'

class ConsoleSnake
  class << self
    def start
      @direction = 'C'

      tate, yoko = IO.console.winsize.map {|i| i + 1 }
      @position = {x: yoko / 2, y: tate / 2}

      Thread.new do
        move_cursor
      end

      loop do
        print "\e[2J"
        print "\e[#{@position[:y]};#{@position[:x]}H"

        case @direction
        when 'A'
          @position[:y] -= 1
        when 'B'
          @position[:y] += 1
        when 'C'
          @position[:x] += 2
        when 'D'
          @position[:x] -= 2
        end

        if /A|B/ === @direction
          exit if @position[:y] < 0 || tate < @position[:y]
        else
          exit if @position[:x] < 0 || yoko < @position[:x]
        end

        print '[]'

        sleep 0.05
      end
    end

    private

    def move_cursor
      while key = STDIN.getch
        # NOTE enable to cancel a game by ctrl-c
        exit if key == "\C-c"

        if key == "\e" && STDIN.getch == "["
          key = STDIN.getch

          next if /A|B/ === @direction && /A|B/ === key
          next if /C|D/ === @direction && /C|D/ === key

          @direction = key
        end
      end
    end

    def print_block
      piece = '[]'

      if /C|D/ === @direction
        print piece * 4
        print "\e[8D"
      else
        4.times do
          print piece
          print "\e[2D"
          print "\e[B"
        end
      end
    end
  end
end
