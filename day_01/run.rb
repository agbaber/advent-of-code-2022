class ElfSnacks
  def initialize(filename)
    @input = File.read(filename)
    @elves = {}
  end

  def run
    @i = 0

    @input.each_line do |line|
      unless @elves[@i]
        @elves[@i] = {total: 0, values: []}
      end

      if line == "\n"
        @i += 1
      else
        @elves[@i][:total] += line.to_i
        @elves[@i][:values] << line.to_i
      end
    end

    # puts @elves.max_by {|e,v| v[:total]} # part 1
    puts @elves.sort_by {|e,v| v[:total]}.reverse[0..2].map {|k,v| v[:total]}.inject(&:+) # part 2
  end

  private

end

ElfSnacks.new('input.txt').run