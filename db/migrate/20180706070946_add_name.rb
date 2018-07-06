class AddName < ActiveRecord::Migration[5.2]
  def change
    add_column :histories, :station_name, :string, default: "apple"
  end
end
