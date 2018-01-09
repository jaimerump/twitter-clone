class CreateMentions < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :tweets, table_name: :mentions
  end
end
