class Retweet < ApplicationRecord
  belongs_to :retweeter, class_name: "User"
  belongs_to :origin_tweet, class_name: "Tweet"

end
