require 'tty'
require 'console_snake/version'
require 'console_snake/background'
require 'pry'

class ConsoleSnake
  class << self
    def start
      console_vertical, console_horizontal = IO.console.winsize.map {|s| s - 1 }
      @background = ConsoleSnake::Background.new(console_vertical, console_horizontal)

      Thread.new do
        move_snake
      end

      loop do
        @background.move!

        exit if @background.position[:y] < 0 || console_vertical < @background.position[:y]
        exit if @background.position[:x] < 0 || console_horizontal < @background.position[:x]

        @background.pretty_print

        sleep 0.5
      end
    end

    private

    def move_snake
      while key = STDIN.getch
        # NOTE enable to cancel a game by ctrl-c
        exit if key == "\C-c"

        if key == "\e" && STDIN.getch == "["
          key = STDIN.getch

          next unless /A|B|C|D/ === key

          @background.turn!(key)
        end
      end
    end
  end
end
