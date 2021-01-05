class CreatePuzzlesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :puzzles do |t|
      t.string :title
      t.string :design
      t.integer :number_of_pieces
      t.boolean :makes_back_sore
    end
  end
end