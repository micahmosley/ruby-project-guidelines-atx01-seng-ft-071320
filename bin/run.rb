require_relative '../config/environment'
def print_text(lines_top, lines_bottom, text)
    lines_top.times do
        print "\n"
    end
    print text
    lines_bottom.times do
        print "\n"
    end
end

def time_passing
    time = Time.now.to_i
    until Time.now.to_i > time 
    end
end

lines = 4
text = "hello world"
bottomlines = lines

while bottomlines >= 0
    #a second passes
    time_passing
    #this clears the terminal of all existing text
    puts "\e[2J\e[f"
    print_text(lines - bottomlines, bottomlines, text)
    bottomlines -= 1
end


