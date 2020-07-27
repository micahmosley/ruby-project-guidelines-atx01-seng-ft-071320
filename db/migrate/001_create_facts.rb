class CreateFacts < ActiveRecord::Migration[5.0]
    def change
      create_table :facts do |t|
        t.string :fact
        t.string :true_or_false
      end
    end
  end

