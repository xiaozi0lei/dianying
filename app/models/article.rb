class Article < ActiveRecord::Base
  attr_accessible :text, :title, :tag_list, :picture, :user_id, :sticky
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: {minimum: 1}
  # seperate articles to different tags
  acts_as_taggable
  acts_as_taggable_on :tags
  # upload picture
  mount_uploader :picture, PictureUploader
  # FriendlyId for URL human format
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
end
