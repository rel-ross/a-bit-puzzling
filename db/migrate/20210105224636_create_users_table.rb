class CreateUsersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name 
      t.references :puzzle
      t.boolean :puzzle_complete

    end

  end
end
