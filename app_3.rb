require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "Entrez votre nom:"
print "> "

my_game = Game.new(gets.chomp)

while my_game.is_still_ongoing? 
  my_game.show_players

  my_game.menu
  
  my_game.menu_choice(gets.chomp)
  
  my_game.enemies_attack 
  
  my_game._end 
  
end

