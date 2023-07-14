class CreateRetweets < ActiveRecord::Migration[7.0]
  def change
    create_table :retweets do |t|
      t.integer :retweeter_id
      t.integer :origin_tweet_id

      t.timestamps
    end

    add_index :retweets, :retweeter_id
    add_index :retweets, :origin_tweet_id
    add_index :retweets, [:retweeter_id, :origin_tweet_id], unique: true
  end
end
