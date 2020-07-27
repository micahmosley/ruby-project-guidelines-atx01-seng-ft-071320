class CreateFacts < ActiveRecord::Migration[5.0]
    def change
      create_table :facts do |t|
        t.string :fact
        t.boolean :true_or_false
      end
    end
  end

