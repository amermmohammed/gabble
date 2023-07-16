class Tweet < ApplicationRecord
  include PublicActivity::Model
  include Gravatarify::Helper

  after_create :resolve_mentions

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

  def resolve_mentions
    mentions = content_html.scan(/@\w+/)
    mentions.uniq.map do |match|
      mention = find_mention(match)
      next unless mention
      update!(content_html: replace_mention_with_url(mention, content_html))
      create_activity key: "tweet.mention", owner: user, recipient: mention
    end
  end

  def find_mention(match)
    user = User.find_by(username: match.delete("@"))
    user if user.present?
  end

  def replace_mention_with_url(mention, content)
    profile_url = Rails.application.routes.url_helpers.user_path(mention.username)
    avatar_html = gravatar_tag(mention.email, size: 20, filetype: :png, alt: mention.username)
    content.gsub(/@#{mention.username}/,
                 "<a href='#{profile_url}' target='_blank' title='#{mention.username}'>
                  #{avatar_html}
                  @#{mention.username}
                </a>")
  end

end
