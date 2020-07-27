class Game < ActiveRecord::Base
    has_many :questions
    has_many :facts, through: :questions

    def self.high_scores
        Game.all.order(score: :desc).limit(10)
    end
end 