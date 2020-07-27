class Controller

    def intro
        Controller.welcome
        puts "Hello, brave user. What is your name?"
        name=gets.chomp

        #create new instance of game and store user's name into username
        current_game=Game.new(username: name)

        puts "Mighty #{name}! Welcome to ____!"
        puts "Do you know how to play? (Y/N)"
        y_or_n=gets.chomp 

        #if user knows how to play start game. else, go over rules
        if y_or_n.downcase=="y"
            begin_game 
        elsif y_or_n.downcase=="n"
            rules
        else 
            while y_or_n.downcase!="y" && y_or_n.downcase!="n"   do 
                puts "Do you know how to play? (Y/N)"
                y_or_n=gets.chomp 
            end 
        end 
    end 

    def begin_game 
        #shuffle all Fact instances and pop off the last fact
        facts=Fact.all.shuffle
        fact=facts.pop
        #start making questions fall down screen
        fact.fact
    end 

    def self.welcome 

        puts "WELCOME TO _____"

    end 

    def rules 
        puts "When a game begins questions will begin falling down your screen.".red
        sleep 6
        puts "Don't be scared! You have until the question hits the floor (bottom of your screen) to answer.".blue
        sleep 6
        puts "All questions are true/false and are answered with a 't' or a 'f'".green
        sleep 6
        puts "For each question you answer correctly, your score will go up by 1.".red
        sleep 6
        puts "For each question you answer incorrectly you lose 1 life point.".blue
        sleep 6
        puts "If you fail to answer a question before it hits the floor you also lose 1 life point.".green
        sleep 6
        puts "You start each game with 3 life points. And it is game over when you hit 0 life points.".red
        sleep 6
        puts "After answering each question. You will automatically be moved to answering the next question.".blue
        sleep 6
        puts "The current question you are answering will be highlighted.".green
        sleep 6
        puts "You must answer questions in order from bottom up.".cyan
        sleep 6

        puts "Would you like to hear the rules again? (Y/N)"
        again=gets.chomp
        if again.downcase=="y"
            rules
        elsif y_or_n.downcase=="n"
            begin_game
        else 
            while y_or_n.downcase!="y" && y_or_n.downcase!="n"   do 
                puts "Would you like to hear the rules again? (Y/N)"
                y_or_n=gets.chomp 
            end 
        end 
    end 




end 