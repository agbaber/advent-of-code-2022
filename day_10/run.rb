class Runner

  # addx V takes two cycles to complete. After two cycles, the X register is increased by the value V. (V can be negative.)
  # noop takes one cycle to complete. It has no other effect.

  def initialize(filename)
    @input = File.read(filename)
    @instructions = []
    @register = 1
    @cycle_num = 1
    @signals = {}
    @previous_instruction = nil
    parse_input
  end

  def run
    require 'pry';binding.pry
    until @cycle_num == 221
      puts '---'
      puts "starting cycle #{@cycle_num}"
      puts "register is #{@register}"

      if @cycle_num == 20 || ((@cycle_num - 20) % 40 == 0)
        # require 'pry';binding.pry
        if @skip_next
          puts "setting signal for cycle #{@cycle_num} to #{@cycle_num * (@register - @previous_instruction)}"
          @signals[@cycle_num] = @cycle_num * (@register - @previous_instruction)
        else
          puts "setting signal for cycle #{@cycle_num} to #{@cycle_num * @register}"
          @signals[@cycle_num] = @cycle_num * @register
        end
      end

      if @skip_next
        puts "skipping cycle"
        @skip_next = false
      else
        next_instruction = @instructions.shift

        unless next_instruction.nil?
          @previous_instruction = next_instruction
          puts "adding #{next_instruction}"
          @register += next_instruction
          @skip_next = true
        end
      end

      @cycle_num += 1
    end

    puts @signals.map {|k,v| v}.inject(&:+)
  end

  private

  def parse_input
    @input.each_line do |line|
      if line == "noop\n"
        @instructions << nil
      elsif matchdata = /addx (.\d+*)/.match(line)
        @instructions << matchdata[1].to_i
      end
    end
  end
end

Runner.new('input.txt').run
