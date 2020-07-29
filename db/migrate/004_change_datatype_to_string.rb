class ChangeDatatypeToString < ActiveRecord::Migration[5.0]
    def change
      change_column :facts, :true_or_false, :string
    end
  end