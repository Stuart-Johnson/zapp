class CreateSpecies < ActiveRecord::Migration[7.2]
  def change
    create_table :species do |t|
      t.string :name
      t.string :color

      t.timestamps
    end
    
    add_reference :animals, :species, foreign_key: true
    remove_column :animals, :species, :string
  end
end
