class Tweet < ApplicationRecord
  include PublicActivity::Model

  # add acts_as_votable to the model
  acts_as_votable
  acts_as_commentable

  # @user.likes @tweet

  # add relationships to the user model
  belongs_to :user

  has_many :retweets, dependent: :destroy, foreign_key: "origin_tweet_id" # if tweet is deleted, all retweets are deleted

  # add validations of the content existence and length
  validates_presence_of :content
  validates_length_of :content, maximum: 200, notice: "Gabbles are limited to 200 characters."

  # add auto_html to the user model
  FORMAT = AutoHtml::Pipeline.new(
    AutoHtml::HtmlEscape.new,
    AutoHtml::Link.new(target: "_blank", rel: "nofollow"),
    AutoHtml::SimpleFormat.new
  )

  def content=(c)
    super(c)
    self[:content_html] = FORMAT.call(c)
  end

end
