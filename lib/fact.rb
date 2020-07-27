class Fact < ActiveRecord::Base
    has_many :questions
    has_many :games, through: :questions
end 