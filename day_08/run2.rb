class Runner
  def initialize(filename)
    @input = File.read(filename)
    @rows = []
    @columns = []
    @max_score = 0
    @max_point = []
    parse_input
  end

  def run
    @rows.each_with_index do |row, row_i|
      if row_i.zero? || (row_i == (row.size - 1))
        next
      end

      row.each_with_index do |tree, tree_i|
        if tree_i.zero? || (tree_i == (row.size - 1))
          next
        end

        left_score = check_left(tree, tree_i, row_i)
        right_score = check_right(tree, tree_i, row_i)
        up_score = check_up(tree, tree_i, row_i)
        down_score = check_down(tree, tree_i, row_i)

        total_score = left_score * right_score * up_score * down_score

        if total_score > @max_score
          @max_score = total_score
          @max_point = [row_i, tree_i]
        end
      end
    end

    puts @max_score
    puts @max_point.inspect
  end

  private

  def check_up(v, x, y)
    score = 0

    @columns[x][0..y-1].reverse.each do |t|
      if t < v
        score += 1
      elsif t >= v
        score += 1
        break
      end
    end

    score
  end

  def check_down(v, x, y)
    score = 0

    @columns[x][y+1..-1].each do |t|
      if t < v
        score += 1
      elsif t >= v
        score += 1
        break
      end
    end

    score
  end

  def check_left(v, x, y)
    score = 0

    @rows[y][0..x-1].reverse.each do |t|
      if t < v
        score += 1
      elsif t >= v
        score += 1
        break
      end
    end

    score
  end

  def check_right(v, x, y)
    score = 0

    @rows[y][x+1..-1].each do |t|
      if t < v
        score += 1
      elsif t >= v
        score += 1
        break
      end
    end

    score
  end

  def parse_input
    @input.each_line do |line|
      @rows << line.chomp.chars.map(&:to_i)
    end

    @columns = @rows.transpose
  end

end

Runner.new('input.txt').run
