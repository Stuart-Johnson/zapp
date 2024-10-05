class CreateDietEntries < ActiveRecord::Migration[7.2]
  def change
    create_table :diet_entries do |t|
      t.references :animal, null: false, foreign_key: true
      t.references :food, null: false, foreign_key: true
      t.jsonb :meals, default: {}

      t.timestamps
    end
  end
end
