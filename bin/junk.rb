require_relative '../config/environment'

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


def scrolling_text(bottomlines, lines, text)
    
    spaces = rand(150)
    while bottomlines >= 0
        sleep(1)
        print_text(lines - bottomlines, bottomlines, spaces, text)
        bottomlines -= 1
    end
    print_text(5, 5, "you lose!")

end


# def get_answer(fact)
#     answer=gets.chomp 
#     #if the answer is correct
#     if (answer="t" && fact=="True") || (answer=="f" && fact=="False")
#         scrolling_text.kill
#         puts "You win"
#     #if the answer is wrong 
#     else 
#         scrolling_text.kill
#         puts "You lose"
#     end 
# end 

#method that sends a fact falling from the top of the screen and takes in an answer
def ask_question(lines, text)
    bottomlines = lines
    scrolling_text(bottomlines, lines, text)
    
end

ask_question(10, "hello world")
# game_thread_b=Thread.new{ask_questionk(10, "Yo")}
# game_thread_a.join
# game_thread_b.join




