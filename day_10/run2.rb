class Runner

  # addx V takes two cycles to complete. After two cycles, the X register is increased by the value V. (V can be negative.)
  # noop takes one cycle to complete. It has no other effect.

  def initialize(filename)
    @input = File.read(filename)
    @instructions = []
    @print_row = Array.new(6, Array.new(40,'.'))
    @current_row = 0
    @register = 1
    @cycle_num = 1
    @signals = {}
    @previous_instruction = nil
    parse_input
  end

  def run
    until @cycle_num == 240
      # puts '---'
      # puts "starting cycle #{@cycle_num}"
      # puts "register is #{@register}"

      if (@register-1..@register+1).to_a.include?(@cycle_num % 40)
        @print_row[@current_row][(@cycle_num % 40)] = '#'
      end

      if @cycle_num % 40 == 0
        if @skip_next
          # puts "setting signal for cycle #{@cycle_num} to #{@cycle_num * (@register - @previous_instruction)}"
          @signals[@cycle_num] = @cycle_num * (@register - @previous_instruction)
        else
          # puts "setting signal for cycle #{@cycle_num} to #{@cycle_num * @register}"
          @signals[@cycle_num] = @cycle_num * @register
        end

        puts @print_row[@current_row].join('')
        @print_row = Array.new(6, Array.new(40,'.'))

        @current_row += 1
      end



      if @skip_next
        # puts "skipping cycle"
        @skip_next = false
      else
        next_instruction = @instructions.shift

        unless next_instruction.nil?
          @previous_instruction = next_instruction
          # puts "adding #{next_instruction}"
          @register += next_instruction
          @skip_next = true
        end
      end

      @cycle_num += 1
    end

        puts @print_row[@current_row].join('')
  end

  private

  def parse_input
    @input.each_line do |line|
      if line == "noop\n"
        @instructions << nil
      elsif matchdata = /addx (.\d*)/.match(line)
        @instructions << matchdata[1].to_i
      end
    end
  end
end

Runner.new('input.txt').run
