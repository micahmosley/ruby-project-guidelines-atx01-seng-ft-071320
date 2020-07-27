class CreateQuestions < ActiveRecord::Migration[5.0]
    def change
      create_table :questions do |t|
        t.integer :fact_id
        t.integer :game_id
        t.boolean :answered_correctly
      end
    end
  end