class AddDietTypeToSpecies < ActiveRecord::Migration[7.2]
  def change
    add_column :species, :diet_type, :string
  end
end
