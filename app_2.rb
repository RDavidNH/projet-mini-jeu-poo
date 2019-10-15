require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "-----------------------------------------------"
puts "Bienvenue sur 'ILS VEULENT TOUS MA POO' !"
puts "Le but du jeu est d'être le dernier survivant !"
puts "-----------------------------------------------"

puts "Entrez votre nom:"
print "> "

hplayer = HumanPlayer.new(gets.chomp)

#enemies = [Player.new("Josiane"), Player.new("José")]
player1 = Player.new("Josiane")
player2 = Player.new("José")

while hplayer.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
  puts "Voici l'état de chaque joueur : "
  hplayer.show_state
  player1.show_state
  player2.show_state
  
  puts "===================================="
  
  puts "Quelle action veux-tu effectuer ?"  
  puts "----------------------------------"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner "
  puts "----------------------------------"
  puts "attaquer un joueur en vue :"
  print "0 - "
  player1.show_state
  print "1 - " 
  player2.show_state 
  
  action = gets.chomp

  if action == "a"
    hplayer.search_weapon
  end
  
  if action == "s"
    hplayer.search_health_pack
  end
  
  if action == "0"
    hplayer.attacks(player1)
  elsif action == "1"
    hplayer.attacks(player2)
  end
  
  puts "===================================="
  
  #break
end

puts "La partie est finie"

if hplayer.life_points > 0
  puts "BRAVO! TU AS GAGNE!"
else
  puts "Loser! Tu as perdu!"
end



