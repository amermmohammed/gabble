class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :relationships, :follower_id # This is the user who is following
    add_index :relationships, :followed_id # This is the user who is being followed
    add_index :relationships, [:follower_id,:followed_id], unique: true # This is to ensure that a user can't follow another user more than once
  end
end
