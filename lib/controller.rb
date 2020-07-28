class Controller

    def intro
        Controller.welcome
        puts "Hello, brave user. What is your name?"
        name=gets.chomp

        #create new instance of game and store user's name into username
        @@current_game=Game.new(username: name)

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
        #shuffle all Fact instances and store in variable facts
        facts=Fact.all.shuffle
        @@current_game.score=0
        @@lives=3
        
        #need to make a case for if we run out of questions
        while @@lives>0 do 
            fact=facts.pop
            #Ask a question that will begin falling down screen
            ask_question(10, fact)
           
        end 
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

    #method that prints test in the correct vertical position
    def print_text(lines_top, lines_bottom, spaces, text)
        puts "\e[2J\e[f"
        lines_top.times do
            print "\n"
        end
        spaces.times do
            print " "
        end
        print text
        lines_bottom.times do
            print "\n"
        end
    end

#method that sends a fact falling from the top of the screen and takes in an answer
    def ask_question(lines, fact)
        bottomlines = lines
        
        begin
            scrolling_text = Thread.new{
                spaces = rand(150)
                while bottomlines >= 0
                    if @@current_game.score<5
                        sleep(1)
                    elsif @@current_game.score>=5 && @@current_game.score<10
                        sleep(.8)
                    else 
                        sleep(.5)
                    end
                    print_text(lines - bottomlines, bottomlines, spaces, fact.fact)
                    bottomlines -= 1
                end
            }
            
            
            get answer = Timeout::timeout(lines) {answer = gets.chomp}
            if (get_answer.downcase=="t" && fact.true_or_false=="True") || (get_answer.downcase=="f" && fact.true_or_false=="False")
                scrolling_text.kill
                @@current_game.score+=1
            else
                scrolling_text.kill
                @@lives-=1
            end
            scrolling_text.join
        rescue Timeout::Error
            print_test(5,5,10, "you lose!")
        end
    end

    def game_over_screen
        print ("                                             .         .                                                                                                   
            ,o888888o.         .8.                  ,8.       ,8.         8 8888888888               ,o888888o. `8.`888b           ,8'8 8888888888  8 888888888o.  
           8888     `88.      .888.                ,888.     ,888.        8 8888                  . 8888     `88.`8.`888b         ,8' 8 8888        8 8888    `88. 
        ,8 8888       `8.    :88888.              .`8888.   .`8888.       8 8888                 ,8 8888       `8b`8.`888b       ,8'  8 8888        8 8888     `88 
        88 8888             . `88888.            ,8.`8888. ,8.`8888.      8 8888                 88 8888        `8b`8.`888b     ,8'   8 8888        8 8888     ,88 
        88 8888            .8. `88888.          ,8'8.`8888,8^8.`8888.     8 888888888888         88 8888         88 `8.`888b   ,8'    8 8888888888888 8888.   ,88' 
        88 8888           .8`8. `88888.        ,8' `8.`8888' `8.`8888.    8 8888                 88 8888         88  `8.`888b ,8'     8 8888        8 888888888P'  
        88 8888   8888888.8' `8. `88888.      ,8'   `8.`88'   `8.`8888.   8 8888                 88 8888        ,8P   `8.`888b8'      8 8888        8 8888`8b      
        `8 8888       .8.8'   `8. `88888.    ,8'     `8.`'     `8.`8888.  8 8888                 `8 8888       ,8P     `8.`888'       8 8888        8 8888 `8b.    
           8888     ,88.888888888. `88888.  ,8'       `8        `8.`8888. 8 8888                  ` 8888     ,88'       `8.`8'        8 8888        8 8888   `8b.  
            `8888888P'.8'       `8. `88888.,8'         `         `8.`8888.8 888888888888             `8888888P'          `8.`         8 8888888888888 8888     `88.  ")
    end

    def high_scores_title
        print("                                                                                                                           
        8 8888        8 8 8888            d888888o.      ,o888888o.       ,o888888o.    8 888888888o.  8 8888888888    d888888o.  
        8 8888        8 8 8888          .`8888:' `88.   8888     `88.  . 8888     `88.  8 8888    `88. 8 8888        .`8888:' `88.
        8 8888        8 8 8888          8.`8888.   Y8,8 8888       `8.,8 8888       `8b 8 8888     `88 8 8888        8.`8888.   Y8
        8 8888        8 8 8888          `8.`8888.    88 8888          88 8888        `8b8 8888     ,88 8 8888        `8.`8888.    
        8 8888        8 8 8888           `8.`8888.   88 8888          88 8888         888 8888.   ,88' 8 888888888888 `8.`8888.   
        8 8888        8 8 8888            `8.`8888.  88 8888          88 8888         888 888888888P'  8 8888          `8.`8888.  
        8 8888888888888 8 8888             `8.`8888. 88 8888          88 8888        ,8P8 8888`8b      8 8888           `8.`8888. 
        8 8888        8 8 8888         8b   `8.`8888.`8 8888       .8'`8 8888       ,8P 8 8888 `8b.    8 8888       8b   `8.`8888.
        8 8888        8 8 8888         `8b.  ;8.`8888   8888     ,88'  ` 8888     ,88'  8 8888   `8b.  8 8888       `8b.  ;8.`8888
        8 8888        8 8 8888          `Y8888P ,88P'    `8888888P'       `8888888P'    8 8888     `88.8 888888888888`Y8888P ,88P'")
    end

    def main_menu
        print ("
              .         .                                                                         .         .                                                      
             ,8.       ,8.                  .8.          8 8888b.             8                  ,8.       ,8.         8 8888888888  b.             88 8888      88
            ,888.     ,888.                .888.         8 8888888o.          8                 ,888.     ,888.        8 8888        888o.          88 8888      88
           .`8888.   .`8888.              :88888.        8 8888Y88888o.       8                .`8888.   .`8888.       8 8888        Y88888o.       88 8888      88
          ,8.`8888. ,8.`8888.            . `88888.       8 8888.`Y888888o.    8               ,8.`8888. ,8.`8888.      8 8888        .`Y888888o.    88 8888      88
         ,8'8.`8888,8^8.`8888.          .8. `88888.      8 88888o. `Y888888o. 8              ,8'8.`8888,8^8.`8888.     8 8888888888888o. `Y888888o. 88 8888      88
        ,8' `8.`8888' `8.`8888.        .8`8. `88888.     8 88888`Y8o. `Y88888o8             ,8' `8.`8888' `8.`8888.    8 8888        8`Y8o. `Y88888o88 8888      88
       ,8'   `8.`88'   `8.`8888.      .8' `8. `88888.    8 88888   `Y8o. `Y8888            ,8'   `8.`88'   `8.`8888.   8 8888        8   `Y8o. `Y88888 8888      88
      ,8'     `8.`'     `8.`8888.    .8'   `8. `88888.   8 88888      `Y8o. `Y8           ,8'     `8.`'     `8.`8888.  8 8888        8      `Y8o. `Y8` 8888     ,8P
     ,8'       `8        `8.`8888.  .888888888. `88888.  8 88888         `Y8o.`          ,8'       `8        `8.`8888. 8 8888        8         `Y8o.`  8888   ,d8P 
    ,8'         `         `8.`8888..8'       `8. `88888. 8 88888            `Yo         ,8'         `         `8.`8888.8 8888888888888            `Yo   `Y88888P'  ")
    end
    
    

end 