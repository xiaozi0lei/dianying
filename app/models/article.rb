class Article < ActiveRecord::Base

  attr_accessible :text, :title, :tag_list, :picture, :user_id, :sticky, :impressionable_type, :impressionable_id, :controller_name, :action_name, :user_id, :request_hash, :session_hash, :ip_address, :referrer
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: {minimum: 1}

  # track the article action visit counter
  is_impressionable :counter_cache => true, :unique => false

  # seperate articles to different tags
  acts_as_taggable
  acts_as_taggable_on :tags

  # upload picture
  mount_uploader :picture, PictureUploader

  # FriendlyId for URL human format
  extend FriendlyId
  #friendly_id :title, use: [:slugged, :history]
  friendly_id :title, use: :slugged

  def normalize_friendly_id(input)
    input.to_s.to_url
  end

  # full-text search
  searchable do
    text :title, :boost => 5
    text :text, :publish_month
    text :comments do
      comments.map(&:body)
    end
    string :publish_month
  end

  def publish_month
    created_at.strftime("%B %Y")
  end

end
