class Runner
  def initialize(filename)
    @input = File.read(filename)
    @instructions = {}
    @directory_changes = []
    @directories = {'/' => {size: 0, subdirectories: []}}
    @filesystem = []
    @current_path = []
    @pwd = '/'
    parse_input
  end

  def run
    @instructions.each_with_index do |instruction, i|
      if matchdata = /^\$ cd (\S*)/.match(instruction[1])
        puts "changing to #{matchdata[1]}"
        change_dir(matchdata[1])
      end

      if matchdata = (/^\$ ls/).match(instruction[1])
        create_files_and_dirs(get_files_and_dirs(instruction))
      end
    end
    puts @directories.inspect
    puts @directories.select {|k,v| v[:size] <= 100000}.map {|k,v| v[:size]}.inject(&:+)
  end

  private

  def create_files_and_dirs(files_and_dirs)
    files_and_dirs&.each do |obj|
      # require 'pry';binding.pry
      if matchdata = /^dir (\S*)/.match(obj[1])
        puts "creating dir #{matchdata[1]}"
        @directories["#{@current_path.join('/')}/#{matchdata[1]}"] = {size: 0, subdirectories: []}
        @directories[@current_path.join('/')][:subdirectories] << matchdata[1]
      end

      if matchdata = /^(\d*) (\S*)/.match(obj[1])
        # require 'pry';binding.pry
        puts "creating file #{obj[1]}"
        temp_path = @current_path.dup
        until temp_path.empty?
          @directories[temp_path.join('/')][:size] += matchdata[1].to_i
          temp_path.pop
        end
      end
    end
  end

  def change_dir(dir)
    # require 'pry';binding.pry
    case dir
    when '/'
      @current_path = ['/']
    when '..'
      @current_path.pop
    else
      @current_path << dir
    end
  end

  def get_files_and_dirs(cd_instruction)
    next_cd = @directory_changes.select {|dc| dc[:instruction_id] > cd_instruction[0]}.first

    if next_cd
      @instructions.select {|k,v| (cd_instruction[0]+1...next_cd[:instruction_id]).include?(k)}
    else
      @instructions.select {|k,v| k > cd_instruction[0]}
    end
  end

  def parse_input
    @input.each_line.with_index do |line, i|
      @instructions[i] = line.chomp

      if matchdata = (/^\$ cd (\S*)/).match(line)
        @directory_changes << { instruction_id: i, instruction: matchdata[1] }
      end
    end
  end
end

Runner.new('input.txt').run

#1019191 too low