class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # add acts_as_voter to the user model
  acts_as_voter

  # add validations to the user model
  validates_presence_of :username
  validates_uniqueness_of :username

  # add relationships to the user model
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  # tweets
  has_many :tweets, dependent: :destroy # if user is deleted, all tweets are deleted
  has_many :comments, dependent: :destroy # if user is deleted, all comments are deleted

  # retweets
  has_many :retweets, dependent: :destroy, foreign_key: "retweeter_id" # if user is deleted, all retweets are deleted

  # defining following, unfollow events
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  # defining following?, followers, following events

  def following?(user)
      following.include?(user)
  end

  def self.mentions(letters)
    return User.none unless letters.present?
    users = User.limit(8).where("username like ?", "#{letters}%")
    users.map { |user|
      { name: user.username }
    }
  end

end
