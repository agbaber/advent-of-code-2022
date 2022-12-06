# [F]         [L]     [M]            
# [T]     [H] [V] [G] [V]            
# [N]     [T] [D] [R] [N]     [D]    
# [Z]     [B] [C] [P] [B] [R] [Z]    
# [M]     [J] [N] [M] [F] [M] [V] [H]
# [G] [J] [L] [J] [S] [C] [G] [M] [F]
# [H] [W] [V] [P] [W] [H] [H] [N] [N]
# [J] [V] [G] [B] [F] [G] [D] [H] [G]
#  1   2   3   4   5   6   7   8   9 

# move 6 from 4 to 3
# 1       3     6    9  12
# 2=>1 5=>2 9=>3 13=4 17=>5

class Runner
  def initialize(filename)
    @input = File.read(filename)
    @instructions = []
    @stacks = {}
    parse_input
  end

  def run
    @instructions.each do |instruction|
      move_crates(instruction)
    end

    output = []
    @stacks.sort.each do |k,v|
      output << v.pop
    end

    puts output.join('')
  end

  private

  def move_crates(instruction)
    number_to_move = instruction[0].to_i
    move_from = instruction[1].to_i
    move_to = instruction[2].to_i

    number_to_move.times do
      @stacks[move_to] << @stacks[move_from].pop
    end

    puts @stacks.inspect
  end

  def parse_stacks(rows)
    rows.each do |row|
      row.chars.each_with_index do |c, i|
        ival = if i < 4
          1
        else
          ((i - 1) / 4) + 1
        end

        if /[[:upper:]]/.match(c)
          if @stacks[ival]
            @stacks[ival].insert(0,c)
          else
            @stacks[ival] = [c]
          end
        end
      end
    end
  end


  def parse_input
    stack_rows = []

    @input.each_line do |line|
      if line.split(' ')&.first&.match(/\[*\]/)
        stack_rows << line.chomp
      elsif line.match(/move (\d*) from (\d*) to (\d*)/)
        matchdata = line.match(/move (\d*) from (\d*) to (\d*)/)

        @instructions << [matchdata[1], matchdata[2], matchdata[3]]
      end
    end

    parse_stacks(stack_rows)
  end

end

Runner.new('input.txt').run
