require 'matrix'

class Runner
  def initialize(filename)
    @input = File.read(filename)
    @instructions = []
    parse_input
    @head_position = [5,0]
    @tail_position = [5,0]
    @head_visited_positions = [[5,0]]
    @tail_visited_positions = [[5,0]]
  end

  def run
    @instructions.each do |direction, steps|
      puts "== #{direction} #{steps} =="
      step = 0
      steps.times do
        step += 1
        previous_head = @head_position.dup
        move_head(direction)
        check_and_move_tail(direction, previous_head)

        # if [1,2,3].include?(step)
          # print_debug
        # end
      end
    end

    puts @tail_visited_positions.uniq.size
  end

  private

  def changed_dir?
    @x_delta = @head_position[0].abs - @tail_position[0].abs
    @y_delta = @head_position[1].abs - @tail_position[1].abs

    @x_delta.abs == 1 && @y_delta.abs == 1
  end

  def check_and_move_tail(direction, previous_head)
    unless changed_dir? || within_1?
      @tail_position = previous_head
      @tail_visited_positions << @tail_position.dup
    end
  end

  def move_head(direction)
    case direction
    when 'U'
      @head_position[0] -= 1
    when 'D'
      @head_position[0] += 1
    when 'L'
      @head_position[1] -= 1
    when 'R'
      @head_position[1] += 1
    end

    @head_visited_positions << @head_position.dup
  end

  def parse_input
    @input.each_line do |line|
      a,b = line.split(' ')
      @instructions << [a, b.to_i]
    end
  end

  def print_debug
    matrix = (Matrix.build(6, 6) {|row, col| '.' }).to_a

    matrix[5][0] = 's'
    if matrix[@tail_position[0]]
      matrix[@tail_position[0]][@tail_position[1]] = 'T'
    end

    if matrix[@head_position[0]]
      matrix[@head_position[0]][@head_position[1]] = 'H'
    end

    puts "\n"
    matrix.each do |r|
      puts r.join('')
    end
  end

  def within_1?
    (@x_delta.abs + @y_delta.abs) <= 1
  end
end

Runner.new('input.txt').run
# 6063 too low