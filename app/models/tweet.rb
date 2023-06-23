class Tweet < ApplicationRecord
  include PublicActivity::Model
  # add relationships to the user model
  belongs_to :user

  # add validations of the content existence and length
  validates_presence_of :content
  validates_length_of :content, maximum: 200, message: "Gabbles are limited to 140 characters."

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
