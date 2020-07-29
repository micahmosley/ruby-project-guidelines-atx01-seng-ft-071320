class Game < ActiveRecord::Base
    has_many :questions
    has_many :facts, through: :questions

    def self.high_scores
        games=Game.all.order(score: :desc).limit(5)
        games.each do |game|
            print game.username+"   "
            puts game.score
        end 
    end
end 