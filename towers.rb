class TowerOfHanoi
  # Towers modeled as array of arrays, external array : towers , internal arrays : disks
  # Inital state : [[3, 2, 1], [], []]
  def initialize(height)
    @towers = [(1..height).to_a.reverse, [], []]
    @height = height
  end

  # rubocop:disable Metrics/AbcSize
  def render
    level = @height - 1
    while level >= 0
      (0..2).each do |i|
        print ' ' * (@height - @towers[i][level].to_i)
        print '=' * @towers[i][level].to_i
        print '|'
        print '=' * @towers[i][level].to_i
        print ' ' * (@height - @towers[i][level].to_i)
      end
      puts
      level -= 1
    end
    (0..2).each { |i| print "-" * @height + i.to_s + "-" * @height }
    puts
  end

  def play
    # Welcome message with Instructions
    welcome_msg

    # Game loop
    loop do
      puts "Enter Move >"

      # input validation
      from, to = validate_input

      # move disks from one tower to another
      move(from, to)

      # render the state of the towers visually
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
