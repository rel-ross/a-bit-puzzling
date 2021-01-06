class CreatePuzzlesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :puzzles do |t|
      t.string :title
      t.string :design
      t.integer :number_of_pieces
      t.boolean :in_progress
    end
  end
end