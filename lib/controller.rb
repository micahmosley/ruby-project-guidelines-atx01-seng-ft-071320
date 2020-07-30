class Controller

    def intro
        main_menu
        puts "Hello, brave user. What is your name?"
        name=gets.chomp

        #create new instance of game and store user's name into username
        @@current_game=Game.new(username: name)

        puts "Mighty #{name.red}! Welcome to ____!"
        start_game?
    end 

    def start_game?
        puts "Do you know how to play? (Y/N)"
        y_or_n=gets.chomp 

        #if user knows how to play start game. else, go over rules
        if y_or_n.downcase=="y"
            begin_game
        elsif y_or_n.downcase=="n"
            rules
            start_game?
        else 
            start_game?
        end 
    end

    def begin_game 

        
        #shuffle all Fact instances and store in variable facts
        facts=Fact.all.shuffle
        facts=facts.uniq
        @@current_game.score=0
        @@lives=3
        
        #need to make a case for if we run out of questions
        while @@lives>0 do 
            fact=facts.pop
            #Ask a question that will begin falling down screen
            ask_question(10, fact)
            break if Question.all.where("game_id = ?", @@current_game.id).length >= 50
        end 
        @@current_game.save
        game_over
    end 

    def game_over
        game_over_screen
        sleep(2)
        print_text(5, 5, 75, "You got #{@@current_game.score} points!")
        sleep(2)
        retry?
    end

    def retry?
        print_text(5, 5, 75, "Retry? (Y/N)")
     
        y_or_n=gets.chomp 
        if y_or_n.downcase=="y"
            @@last_game = @@current_game
            @@current_game = Game.new(username: @@last_game.username)
            begin_game
        elsif y_or_n.downcase=="n"
            intro
        else
            retry?
        end
    end

    def self.welcome 

        puts "WELCOME TO _____"

    end 

    def rules 
        puts "When a game begins, questions will begin falling down your screen.".red
        puts "Don't be scared! You have until the question hits the floor (bottom of your screen) to answer.".blue
        puts "All questions are true/false and are answered with a 't' or a 'f'".green
        puts "For each question you answer correctly, your score will go up by 1.".red
        puts "However! You can only give three wrong answers before it is game over.".blue
        puts "Letting a question hit the floor counts as giving a wrong answer.".green
        puts "After answering each question, you will automatically be moved to answering the next question.".red

        sleep(20)

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
        timer = lines
        question = Question.create(game: @@current_game, fact: fact)
        
        begin
            scrolling_text = Thread.new{
                spaces = rand(150) - question.fact.fact.length
                while bottomlines >= 0
                    if @@current_game.score<5
                        sleep(1)
                    elsif @@current_game.score>=5 && @@current_game.score<10
                        sleep(0.8)
                        timer = lines * 0.8
                    else 
                        sleep(0.5)
                        timer = lines * 0.5
                    end
                    print_text(lines - bottomlines, bottomlines, spaces, question.fact.fact)
                    bottomlines -= 1
                    puts("=" * 150)
                end
            }
            
            get_answer = Timeout::timeout(timer) {answer = gets.chomp}
            if (get_answer.downcase=="t" && question.fact.true_or_false=="True") || (get_answer.downcase=="f" && question.fact.true_or_false=="False")
                scrolling_text.kill
                @@current_game.score+=1
                question.answered_correctly = true
            else
                scrolling_text.kill
                @@lives -=1
                question.answered_correctly = false
            end
            print_text(5, 5, 75, question.fact.true_or_false)
            sleep(1)
            print_text(5, 5, 75, "Current lives: #{@@lives}")
            if @@current_game.score==5 && question.answered_correctly== true
                print_text(5, 5, 75, "Wow, you're good! Let's speed it up a bit.")
                sleep(1)
            elsif @@current_game.score==10 && question.answered_correctly == true
                print_text(5, 5, 75, "This is too easy. Get ready to see some real speed.")
                sleep(1)
            end 

            scrolling_text.join
        rescue Timeout::Error
            scrolling_text.kill
            @@lives -= 1
            question.answered_correctly = false
            print_text(5, 5, 75, question.fact.true_or_false)
            sleep(1)
            print_text(5, 5, 75, "Current lives: #{@@lives}")
        end
        question.save
    end

    def game_over_screen
        print_text(0,1,0,"                                             .         .                                                                                                   
            ,o888888o.         .8.                  ,8.       ,8.         8 8888888888               ,o888888o. `8.`888b           ,8'8 8888888888  8 888888888o.  
           8888     `88.      .888.                ,888.     ,888.        8 8888                  . 8888     `88.`8.`888b         ,8' 8 8888        8 8888    `88. 
        ,8 8888       `8.    :88888.              .`8888.   .`8888.       8 8888                 ,8 8888       `8b`8.`888b       ,8'  8 8888        8 8888     `88 
        88 8888             . `88888.            ,8.`8888. ,8.`8888.      8 8888                 88 8888        `8b`8.`888b     ,8'   8 8888        8 8888     ,88 
        88 8888            .8. `88888.          ,8'8.`8888,8^8.`8888.     8 888888888888         88 8888         88 `8.`888b   ,8'    8 8888888888888 8888.   ,88' 
        88 8888           .8`8. `88888.        ,8' `8.`8888' `8.`8888.    8 8888                 88 8888         88  `8.`888b ,8'     8 8888        8 888888888P'  
        88 8888   8888888.8' `8. `88888.      ,8'   `8.`88'   `8.`8888.   8 8888                 88 8888        ,8P   `8.`888b8'      8 8888        8 8888`8b      
        `8 8888       .8.8'   `8. `88888.    ,8'     `8.`'     `8.`8888.  8 8888                 `8 8888       ,8P     `8.`888'       8 8888        8 8888 `8b.    
           8888     ,88.888888888. `88888.  ,8'       `8        `8.`8888. 8 8888                  ` 8888     ,88'       `8.`8'        8 8888        8 8888   `8b.  
            `8888888P'.8'       `8. `88888.,8'         `         `8.`8888.8 888888888888             `8888888P'          `8.`         8 8888888888888 8888     `88.  ".yellowish)
    end

    def high_scores_title
        print_text(0, 1, 0,"                                                                                                                           
        8 8888        8 8 8888            d888888o.      ,o888888o.       ,o888888o.    8 888888888o.  8 8888888888    d888888o.  
        8 8888        8 8 8888          .`8888:' `88.   8888     `88.  . 8888     `88.  8 8888    `88. 8 8888        .`8888:' `88.
        8 8888        8 8 8888          8.`8888.   Y8,8 8888       `8.,8 8888       `8b 8 8888     `88 8 8888        8.`8888.   Y8
        8 8888        8 8 8888          `8.`8888.    88 8888          88 8888        `8b8 8888     ,88 8 8888        `8.`8888.    
        8 8888        8 8 8888           `8.`8888.   88 8888          88 8888         888 8888.   ,88' 8 888888888888 `8.`8888.   
        8 8888        8 8 8888            `8.`8888.  88 8888          88 8888         888 888888888P'  8 8888          `8.`8888.  
        8 8888888888888 8 8888             `8.`8888. 88 8888          88 8888        ,8P8 8888`8b      8 8888           `8.`8888. 
        8 8888        8 8 8888         8b   `8.`8888.`8 8888       .8'`8 8888       ,8P 8 8888 `8b.    8 8888       8b   `8.`8888.
        8 8888        8 8 8888         `8b.  ;8.`8888   8888     ,88'  ` 8888     ,88'  8 8888   `8b.  8 8888       `8b.  ;8.`8888
        8 8888        8 8 8888          `Y8888P ,88P'    `8888888P'       `8888888P'    8 8888     `88.8 888888888888`Y8888P ,88P'".yellowish)
    end

    def main_menu
        print_text(0, 1, 0, "
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
    ,8'         `         `8.`8888..8'       `8. `88888. 8 88888            `Yo         ,8'         `         `8.`8888.8 8888888888888            `Yo   `Y88888P'  ".yellowish)

        puts "Main Menu".red
        puts "1. New Game"
        puts "2. High Scores"
        puts "3. Rules"
        puts "4. Quit Game"
        print "Enter 1 to start a new game; 2 for High Scores; 3 to go over the rules; 4 to quit: "

        choice=gets.chomp

        if choice=="1"
            return 
        elsif choice=="2"
            Game.high_scores
            sleep(3)
            main_menu
        elsif choice=="3"
            rules
            main_menu 
        elsif choice=="4"
            exit
        else 
            main_menu
        end
    end 
    
    

end 