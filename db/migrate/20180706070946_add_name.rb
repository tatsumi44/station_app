class AddName < ActiveRecord::Migration[5.2]
  def change
    add_column :histories, :heroku run rake db:migrate, :string, default: "apple"
  end
end
