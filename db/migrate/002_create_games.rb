class CreateGames < ActiveRecord::Migration[5.0]
    def change
      create_table :games do |t|
        t.integer :score
        t.string :username
      end
    end
  end

