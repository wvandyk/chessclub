class AddDrawFlagToMatches < ActiveRecord::Migration[6.1]
  def change
    add_column :matches, :draw, :boolean, default: false
  end
end
