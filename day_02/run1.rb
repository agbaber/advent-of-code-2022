class Runner
  # A - rock
  # B - paper
  # C - scissors

  # X for Rock
  # Y for Paper
  # Z for Scissors

  # score for a single round is the score for the shape you selected
  # (1 for Rock, 2 for Paper, and 3 for Scissors) plus the score for
  # the outcome of the round (0 if you lost, 3 if the round was a draw,
  # and 6 if you won).

  def initialize(filename)
    @input = File.read(filename)
    @rounds = {}
    @score = 0
    @round_num = 0
    parse_input
  end

  def run
    # require 'pry';binding.pry
    @rounds.each do |k,v|
      score_round(v[:guide])
    end

    puts @rounds.map {|k,v| v[:score]}.inject(&:+)
  end

  private

  def parse_input
    @input.each_line do |line|
      @rounds[@round_num] = { guide: line.split(' ') }
      @round_num += 1
    end

    @round_num = 0
  end

  def score_round(guide)
    outcome_points = case guide
    when ['A','X']
      3
    when ['A','Y']
      6
    when ['A','Z']
      0
    when ['B','X']
      0
    when ['B','Y']
      3
    when ['B','Z']
      6
    when ['C','X']
      6
    when ['C','Y']
      0
    when ['C','Z']
      3
    end

    shape_points = case guide[1]
    when 'X'
      1
    when 'Y'
      2
    when 'Z'
      3
    end

    @rounds[@round_num][:score] = outcome_points + shape_points

    @round_num += 1
  end
end

Runner.new('input.txt').run
