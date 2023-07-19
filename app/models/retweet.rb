class Retweet < ApplicationRecord
  include PublicActivity::Model
  validates_uniqueness_of :retweeter_id, scope: :origin_tweet_id
  belongs_to :retweeter, class_name: "User"
  belongs_to :origin_tweet, class_name: "Tweet"
end
