require_relative 'player'

class Game

  attr_accessor :human_player, :enemies
  
  # Create new player and new enemies
  def initialize(name)
    @human_player = HumanPlayer.new(name)
    @enemies = []
    
    for i in 0..4
      @enemies << Player.new('ENEMY ' + i.to_s)
    end
  end
  
  # Remove killed player from enemies array
  def kill_player(player)
    @enemies.delete(player)
  end
  
  # Check if game is not finished yet
  def is_still_ongoing?
    return @human_player.life_points > 0 && @enemies.length > 0 ? true : false
  end
  
  # Display players
  def show_players
    puts ""
    @human_player.show_state
    puts "> Ennemis restant " + @enemies.length.to_s
    puts ""
  end
  
  # Display menu
  def menu
    puts "===================================="
  
    puts "Quelle action veux-tu effectuer ?"  
    puts "----------------------------------"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner "
    puts "----------------------------------"
    puts "Attaquer un joueur en vue :"

    # show enemies states  
    enemies.each_with_index do |enemy, i|
      if enemy.life_points > 0
        print "#{i} -"
        enemy.show_state
      end
    end
  end
  
  # Select an action from menu
  def menu_choice(cmd)
    hplayer = @human_player
    action = cmd

    # define possible actions for the player
    if action == "a"
      hplayer.search_weapon
    elsif action == "s"
      hplayer.search_health_pack
    elsif action.match(/^(\d)+$/) # check if action is a number
      hplayer.attacks(@enemies[action.to_i])
      if @enemies[action.to_i].life_points <= 0
        kill_player(@enemies[action.to_i])
      end
    end
  
  end
  
  # Enemies turn to attack
  def enemies_attack
    @enemies.each do |enemy|
    if enemy.life_points > 0
      enemy.attacks(@human_player)
      break if @human_player.life_points <= 0
    end
  end
  
  # Show end message
  def _end
    message = "La partie est finie"
    if @human_player.life_points > 0 && @enemies.length == 0
      puts message
      puts "BRAVOOOO! TU AS GAGNE!"
    elsif @human_player.life_points <= 0
      puts message
      puts "YOUUU LOOOOSE! Tu as perdu!"
    end
  end
  
  end
end
