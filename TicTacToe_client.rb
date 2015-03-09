require './TicTacToe_workshop.rb'

play1 = Player.new({:mark => "*", :name => "P"})
play2 = Player.new({:mark => "-", :name => "M"})

game = Game.new([play1, play2], Board.new)
game.play