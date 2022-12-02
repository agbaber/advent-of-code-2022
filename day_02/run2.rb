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
    outcome_points = case guide[1]
    when 'X'
      0
    when 'Y'
      3
    when 'Z'
      6
    end

    shown_val = case guide
    when ['A','X']
      'Z'
    when ['A','Y']
      'X'
    when ['A','Z']
      'Y'
    when ['B','X']
      'X'
    when ['B','Y']
      'Y'
    when ['B','Z']
      'Z'
    when ['C','X']
      'Y'
    when ['C','Y']
      'Z'
    when ['C','Z']
      'X'
    end

    shape_points = case shown_val
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
