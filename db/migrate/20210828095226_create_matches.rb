class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.integer :winner_id
      t.integer :winner_previous_rank
      t.integer :loser_id
      t.integer :loser_previous_rank

      t.timestamps
    end
  end
end
