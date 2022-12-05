class Runner
  def initialize(filename)
    @input = File.read(filename)
    @pairs = {}
    @i = 0
    parse_input
    @overlapping_pairs = 0
  end

  def run
    @pairs.each do |k,v|
      overlap?(v)
    end

    puts @overlapping_pairs
  end

  private

  def overlap?(v)
    a = v[:range_a]
    b = v[:range_b]

    if !(((a[0]..a[1]).to_a & (b[0]..b[1]).to_a).empty?)
      puts "#{a.inspect} overlaps with #{b.inspect}"
      @overlapping_pairs += 1
    else
      # puts "#{a.inspect} does not overlap with #{b.inspect}"
    end
  end

  def parse_input
    @input.each_line do |line|
      range_1, range_2 = line.split(',').first.split('-')
      range_3, range_4 = line.split(',').last.split('-')
      @pairs[@i] = { range_a: [range_1.to_i, range_2.to_i], range_b: [range_3.to_i, range_4.chomp.to_i] }
      @i += 1
    end

    @i = 0
  end

end

Runner.new('input.txt').run

# 491 too low