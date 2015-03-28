class Comment < ActiveRecord::Base
  belongs_to :article
  attr_accessible :body, :commenter
  validates :body, presence: true, length: {minimum: 1}
end
