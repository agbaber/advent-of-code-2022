require 'pry'

class Runner
  def initialize(filename)
    @input = File.read(filename)
    @map = []
    @coordinate_options = {}
    parse_input
    @start_point = find_point('S')
    @end_point = find_point('E')
  end

  def run
    @map.each_with_index do |row, row_i|
      row.each_with_index do |value, column_i|
        ac = get_available_coordinates(column_i, row_i, value)
        @coordinate_options[[row_i,column_i]] = ac

        
      end
    end
    

    BreadthFirstSearch.new(@coordinate_options, @start_point).shortest_path_to(@end_point).size + 1
  end

  private

  def get_available_coordinates(x, y, value)
    ac = []

    if value == 'E'
      value = 'z'
    end

    if value == 'S'
      value = 'a'
    end

    if y > 0 && @map[y-1] && @map[y-1][x] && ((@map[y-1][x].ord - 96) - 1 <= (value.ord - 96))
      ac << [y-1,x]
    end

    if y < @map.size && @map[y+1] && @map[y+1][x] && ((@map[y+1][x].ord - 96) - 1  <= (value.ord - 96))
      ac << [y+1,x]
    end

    if x > 0 && @map[y][x-1] && ((@map[y][x-1].ord - 96) - 1  <= (value.ord - 96))
      ac << [y,x-1]
    end

    if x < @map.first.size && @map[y][x+1] && ((@map[y][x+1].ord - 96) - 1  <= (value.ord - 96))
      ac << [y,x+1]
    end

    ac
  end

  def find_point(char)
    point = nil

    @map.each_with_index do |row, i|
      idx = row.find_index(char)

      if idx
        point = [i,idx]
      end
    end

    point
  end

  def parse_input
    @input.each_line do |line|
      @map << line.chomp.split('')
    end
  end

  class BreadthFirstSearch
    def initialize(coordinate_options, source_node)
      @coordinate_options = coordinate_options
      @node = source_node
      @visited = []
      @edge_to = {}

      bfs(source_node)
    end

    def shortest_path_to(node)
      return unless has_path_to?(node)
      path = []

      while(node != @node) do
        path.unshift(node)
        node = @edge_to[node]
      end

      path.unshift(@node)
    end

    private

    def bfs(node)
      queue = []
      queue << node
      @visited << node

      while queue.any?
        current_node = queue.shift

         @coordinate_options[current_node]&.each do |adjacent_node|
          next if has_path_to?(adjacent_node)

          queue << adjacent_node
          @visited << adjacent_node
          @edge_to[adjacent_node] = current_node
        end
      end
    end

    def has_path_to?(node)
      @visited.include?(node)
    end
  end
end

Runner.new('input.txt').run
# 489 too low
