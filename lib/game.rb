class Game < ActiveRecord::Base
    has_many :questions
    has_many :facts, through: :questions

    def self.high_scores
        Game.all.order(score: :desc).limit(5)
    end

    def self.high_score_table
        #uses the terminal-table gem to make a high score table
        table = Terminal::Table.new do |t|
            t.style = {:width => 50}
            t.headings = [' ', 'Player', 'Score']
            i = 0
            while i < Game.high_scores.length do
                t.add_separator
                t.add_row [i+1, Game.high_scores[i].username, Game.high_scores[i].score.to_s.yellow]
                i += 1
            end
        end
        print table
    end
end 