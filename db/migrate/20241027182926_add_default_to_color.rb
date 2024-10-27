class AddDefaultToColor < ActiveRecord::Migration[7.2]
  def change
    change_column_default :species, :color, from: nil, to: '#ffffff'
  end
end
