class Question < ActiveRecord::Base
    belongs_to :fact
    belongs_to :game
end 