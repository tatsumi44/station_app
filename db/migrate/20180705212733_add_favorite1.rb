class AddFavorite1 < ActiveRecord::Migration[5.2]
  def change
    add_column :histories, :favorite1, :boolean, default: false
  end
end
