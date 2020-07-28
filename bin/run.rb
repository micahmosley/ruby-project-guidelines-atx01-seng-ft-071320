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

#method that sends a fact falling from the top of the screen and takes in an answer
def ask_question(lines, text)
    bottomlines = lines

    scrolling_text = Thread.new{
        spaces = rand(150)
        while bottomlines >= 0
            sleep(1)
            print_text(lines - bottomlines, bottomlines, spaces, text)
            bottomlines -= 1
        end
        print_text(5, 5, 10, "you lose!")
    }

    answer = gets.chomp
    if answer == "t"
        scrolling_text.kill
        print_text(5, 5, 10, "you win!")
    else
        scrolling_text.kill
        print_text(5, 5, 10, "you lose!")
    end
    scrolling_text.join
end

ask_question(10, "hello world")




