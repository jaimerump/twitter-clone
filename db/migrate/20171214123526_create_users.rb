class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :screen_name

      t.timestamps
    end
    add_index :users, :screen_name, unique: true
  end
end
