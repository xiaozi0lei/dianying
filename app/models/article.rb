class Article < ActiveRecord::Base
  attr_accessible :text, :title, :tag_list
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: {minimum: 1}
  acts_as_taggable
  acts_as_taggable_on :tags
end
