class Runner
  def initialize(filename)
    @input = File.read(filename).chars
    @i = 0
    @ie = 13
    @start_of_packet_position = nil

  end

  def run
    until @start_of_packet_position
      if @input[@i..@ie].uniq.size == 14
        @start_of_packet_position = @ie + 1
      end

      @i += 1
      @ie += 1
    end

    puts @start_of_packet_position
  end

  private

end

Runner.new('input.txt').run
