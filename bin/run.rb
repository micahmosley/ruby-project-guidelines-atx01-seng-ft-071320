require_relative '../config/environment'

#method that prints test in the correct vertical position
def print_text(lines_top, lines_bottom, text)
    puts "\e[2J\e[f"
    lines_top.times do
        print "\n"
    end
    print text
    lines_bottom.times do
        print "\n"
    end
end

#method that just lets a second pass before moving on
def time_passing
    time = Time.now.to_i
    until Time.now.to_i > time 
    end
end


lines = 10
text = "hello world"
bottomlines = lines

scrolling_text = Thread.new{
while bottomlines >= 0
    time_passing
    print_text(lines - bottomlines, bottomlines, text)
    bottomlines -= 1
end
print_text(5, 5, "you lose!")
}

answer = gets.chomp
if answer == "t"
    scrolling_text.kill
    print_text(5, 5, "you win!")
else
    scrolling_text.kill
    print_text(5, 5, "you lose!")
end
scrolling_text.join




