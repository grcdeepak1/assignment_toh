class TowerOfHanoi
  def initialize(height)
    tower1 = (1..height).to_a.reverse
    tower2 = []
    tower3 = []
    @towers = [tower1, tower2, tower3]
    @height = height
  end

  def render
    level = @height - 1
    while level >= 0
      s0 = ' ' * (@height - @towers[0][level].to_i)
      t0 = '=' * @towers[0][level].to_i
      s1 = ' ' * (@height - @towers[1][level].to_i)
      t1 = '=' * @towers[1][level].to_i
      s2 = ' ' * (@height - @towers[2][level].to_i)
      t2 = '=' * @towers[2][level].to_i
      puts "#{s0}#{t0}|#{t0}#{s0}#{s1}#{t1}|#{t1}#{s1}#{s2}#{t2}|#{t2}#{s2}"
      level -= 1
    end
    footer0 = "-" * @height + "0" + "-" * @height
    footer1 = "-" * @height + "1" + "-" * @height
    footer2 = "-" * @height + "2" + "-" * @height
    puts "#{footer0}#{footer1}#{footer2}"
  end

  def play
    welcome_msg
    from = 0
    to   = 0
    loop do
      puts "Enter Move >"
      from, to = validate_input
      move(from, to)
      render
    end
  end

  private

  def move(source_tower, dest_tower)
    if @towers[source_tower].empty?
      puts "Illegal move, source_tower is empty"
    elsif !@towers[dest_tower].empty? && @towers[source_tower].last > @towers[dest_tower].last
      puts "Illegal move, bigger disk cannot be placed on top of smaller disk"
    else
      @towers[dest_tower] << @towers[source_tower].pop
    end
  end

  def welcome_msg
    greet_string = <<-GREETING
    # Welcome to Tower of Hanoi!
    # Instructions:
    # Enter where you'd like to move from and to
    # in the format [0,2] . Enter 'q' to quit.
    GREETING
    puts greet_string
    puts "Current Board state:\n\n"
    render
  end

  def validate_input
    from = 0
    to   = 0
    loop do
      raw_input = gets.chomp
      if raw_input == 'q'
        exit
      else
        from, to = raw_input.split(",").map(&:to_i)
        break if (0..2).cover?(to) && (0..2).cover?(from)
        puts "Please enter a valid input"
      end
    end
    [from, to]
  end
end

t = TowerOfHanoi.new(3)
t.play
