class Runner
  def initialize(filename)
    @input = File.read(filename)
    @rucksacks = {}
    @i = 0
    parse_input
  end

  def run
    # 
    @rucksacks.each do |k,v|
      shared_char = v[:values][0].split('').intersection(v[:values][1].split('')).first
      @rucksacks[@i][:priority] = points(shared_char)
      @rucksacks[@i][:priority_char] = shared_char
      @i += 1
    end

    puts @rucksacks.map {|k,v| v[:priority]}.inject(&:+)
  end

  private

  def parse_input
    @input.each_line do |line|
      values = line.chars.each_slice(line.length / 2).map(&:join)
      values.pop
      @rucksacks[@i] = { values: values, priority: 0, priority_char: nil }
      @i += 1
    end

    @i = 0
  end

  def points(char)
    total = 0
    if /[[:upper:]]/.match(char)
      total += 26
    end

    total += char.downcase.bytes.first - 96
  end
end

Runner.new('input.txt').run
