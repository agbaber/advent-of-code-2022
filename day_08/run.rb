class Runner
  def initialize(filename)
    @input = File.read(filename)
    @rows = []
    @columns = []
    @visible_trees = 0
    parse_input
  end

  def run
    @rows.each_with_index do |row, row_i|
      if row_i.zero? || (row_i == (row.size - 1))
        @visible_trees += row.size
        next
      end

      row.each_with_index do |tree, tree_i|
        if tree_i.zero? || (tree_i == (row.size - 1))
          @visible_trees += 1
          next
        end

        if check_vertical(tree, tree_i, row_i)
          @visible_trees += 1
        elsif check_horizontal(tree, tree_i, row_i)
          @visible_trees += 1
        end
      end
    end

    puts @visible_trees
  end

  private

  def check_vertical(v, x, y)
    v > [@columns[x][0..y-1].max, @columns[x][y+1..-1].max].min
  end

  def check_horizontal(v, x, y)
    v > [@rows[y][0..x-1].max, @rows[y][x+1..-1].max].min
  end

  def parse_input
    @input.each_line do |line|
      @rows << line.chomp.chars.map(&:to_i)
    end

    @columns = @rows.transpose
  end

end

Runner.new('input.txt').run
