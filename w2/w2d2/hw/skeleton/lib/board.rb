class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @player1 = name1
    @player2 = name2
    place_stones
  end

  def place_stones
    @cups = Array.new(14) { Array.new(4) { :stone } }
    # name1's cup
    @cups[6] = []
    # name2's cup
    @cups[13] = []
  end

  def valid_move?(start_pos)
    raise('Invalid starting cup') if start_pos > 12
    raise('Invalid starting cup') if start_pos < 1
  end

  def make_move(start_pos, current_player_name)
    num_stones = @cups[start_pos]
    @cups[start_pos] = []

    next_pos = start_pos
    until num_stones.empty?
      next_pos += 1
      next_pos = 0 if next_pos > 13
      if next_pos == 6
        @cups[6] << num_stones.pop if current_player_name == @player1
      elsif next_pos == 13
        @cups[13] << num_stones.pop if current_player_name == @player2
      else
        @cups[next_pos] << num_stones.pop
      end
    end

    render
    next_turn(next_pos)
  end

  def next_turn(ending_cup_idx)
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].length == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups.take(6).all? { |cup| cup.empty? } ||
    @cups[7..12].all? { |cup| cup.empty? }
  end

  def winner
    player1_count = @cups[6].count
    player2_count = @cups[13].count

    if player1_count == player2_count
      :draw
    else
      player1_count > player2_count ? @name1 : @name2
    end
  end
end
