#-------
# CELL
#-------

class Cell
  attr_accessor :mark
  def initialize(mark = "O")
    @mark = mark
  end
end

#-------
# PLAYER
#-------

class Player
  attr_reader :mark, :name
  def initialize(settings_hsh)
    @mark = settings_hsh.fetch(:mark)
    @name = settings_hsh.fetch(:name)
  end
end

#-------
# BOARD
#-------

class Board
  attr_reader :grid
  def initialize        # Load a game which was stopped in the middle, save the board at any time?
    @grid = default_grid
  end

  def mark_cell(row, column, player_mark)
    @grid[row - 1][column - 1].mark = player_mark
  end

  def display
    @grid.each do |row|
      puts row.inject(" ") {|output, el| output + el.mark + " "}
    end
  end

  private

  def default_grid
    Array.new(3) { Array.new(3) { Cell.new } }
  end
end

#-------
# GAME
#-------

class Game
  def initialize(players, board)
    @board = board
    @current_player, @other_player = players.shuffle
  end

  def play
    puts "Let's start playing! Here is our board:"
    @board.display
    i = 1
    while i <= 9
      puts "#{@current_player.name} it is your turn. Enter the row number followed by the column number of where you want to mark it."
      row = gets.chomp.to_i
      column = gets.chomp.to_i
      @board.mark_cell(row, column, @current_player.mark)
      @board.display
      if won?
        puts "Game is finished! #{@current_player.name} won it!"
        return # Exits the method (terminates program) when winning conditions is met
      end
      switch_players
      i += 1
    end

    # If after 9 iterations there is no winner, it's a draw!
    puts "No moves left. It's a draw!"

  end

  private

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def won?
    search_term = @current_player.mark
    if (@board.grid[0][0].mark == search_term && @board.grid[1][1].mark == search_term && @board.grid[2][2].mark == search_term) || # diagonal
       (@board.grid[0][2].mark == search_term && @board.grid[1][1].mark == search_term && @board.grid[2][0].mark == search_term) || # diagonal
       (@board.grid[0][0].mark == search_term && @board.grid[0][1].mark == search_term && @board.grid[0][2].mark == search_term) || # row 1
       (@board.grid[1][0].mark == search_term && @board.grid[1][1].mark == search_term && @board.grid[1][2].mark == search_term) || # row 2
       (@board.grid[2][0].mark == search_term && @board.grid[2][1].mark == search_term && @board.grid[2][2].mark == search_term) || # row 3
       (@board.grid[0][0].mark == search_term && @board.grid[1][0].mark == search_term && @board.grid[2][0].mark == search_term) || # column 1
       (@board.grid[0][1].mark == search_term && @board.grid[1][1].mark == search_term && @board.grid[2][1].mark == search_term) || # column 2
       (@board.grid[0][2].mark == search_term && @board.grid[1][2].mark == search_term && @board.grid[2][2].mark == search_term)    # column 3
      return true
    else
      return false
    end
  end
end



