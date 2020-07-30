class Game < ActiveRecord::Base
    has_many :questions
    has_many :facts, through: :questions

    def self.high_scores
        Game.all.order(score: :desc).limit(5)
        # games.each do |game|
        #     print game.username+"      "
        #     puts game.score.to_s.yellow
        # end 
    end

    def self.high_score_table
        table = Terminal::Table.new do |t|
            t.style = {:width => 50}
            t.headings = [' ', 'Player', 'Score']
            i = 0
            while i < Game.high_scores.length do
                t.add_separator
                t.add_row [i+1, Game.high_scores[i].username, Game.high_scores[i].score]
                i += 1
            end
        end
        print table
    end
end 