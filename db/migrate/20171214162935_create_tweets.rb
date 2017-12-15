class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.string :message
      t.string :link
      t.references :user, index: true, null: false
      t.references :reply_to, index: true, null: true, default: nil
      # Original tweet probably isn't worth indexing, I added it to avoid the reddit problem of having to iterate
      # over every single level of comments to build out a thread
      t.references :original_tweet, null: true, default: nil 


      t.timestamps
    end
  end
end
