require_relative '../config/environment'

game = Controller.new
game.intro

def retry?
    print_text(5, 5, 75, "Retry? (Y/N)")
 
    y_or_n=gets.chomp 
    if y_or_n.downcase=="y"
        @@last_game = @@current_game
        @@current_game = Game.new(username: @@last_game.username)
        begin_game
    elsif y_or_n.downcase=="n"
        return
    else
        retry?
    end
end