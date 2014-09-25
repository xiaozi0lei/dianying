class Article < ActiveRecord::Base
  attr_accessible :text, :title
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: {minimum: 1}
end
