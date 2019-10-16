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

enemies = [Player.new("Josiane"), Player.new("José")]
player1 = Player.new("Josiane")
player2 = Player.new("José")


#while hplayer.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
while hplayer.life_points > 0
  
  # number of enemies killed
  n_enemies = 0
  enemies.each do |enemy|
    if enemy.life_points <= 0
      n_enemies += 1
    end
  end
  # break loop if no more enemies
  break if enemies.length == n_enemies

  # show players states
  puts "Voici l'état de chaque joueur : "
  hplayer.show_state
  
  # show enemies states
  enemies.each do |enemy|
    enemy.show_state
  end
  
  puts "===================================="
  
  puts "Quelle action veux-tu effectuer ?"  
  puts "----------------------------------"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner "
  puts "----------------------------------"
  puts "attaquer un joueur en vue :"

  # show enemies states  
  enemies.each_with_index do |enemy, i|
    print "#{i} -"
    enemy.show_state
  end

  action = gets.chomp

  # define possible actions for the player
  if action == "a"
    hplayer.search_weapon
  elsif action == "s"
    hplayer.search_health_pack
  elsif action.match(/^(\d)+$/) # check if action is a number
    hplayer.attacks(enemies[action.to_i])
  end
  
  # enemies turn to attack the player
  enemies.each_with_index do |enemy, i|
    if enemy.life_points > 0
      enemy.attacks(hplayer)
    end
  end
  
  print "Appuyez sur Entrer pour continuer"
  gets.chomp

  puts "===================================="
  
  #break
end

puts "La partie est finie"

if hplayer.life_points > 0
  puts "BRAVO! TU AS GAGNE!"
else
  puts "Loser! Tu as perdu!"
end



