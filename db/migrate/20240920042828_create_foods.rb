class CreateFoods < ActiveRecord::Migration[7.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :supplier
      t.string :storage_location
      t.boolean :treat

      t.timestamps
    end
  end
end
