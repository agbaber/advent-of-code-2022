class Runner
  def initialize(filename)
    @input = File.read(filename)
    @rucksacks = {}
    @i = 0
    parse_input
    @group_values = []
  end

  def run
    @rucksacks.each_slice(3) do |slice|
      a = slice[0][1][:values].split('')
      b = slice[1][1][:values].split('')
      c = slice[2][1][:values].split('')

      @group_values << points(a.intersection(b).intersection(c).first)
    end

    puts @group_values.flatten.inject(&:+)
  end

  private

  def parse_input
    @input.each_line do |line|
      @rucksacks[@i] = { values: line.chomp }
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
