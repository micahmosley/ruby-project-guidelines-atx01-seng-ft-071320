class Game < ActiveRecord::Base
    has_many :questions
    has_many :facts, through: :questions
end 