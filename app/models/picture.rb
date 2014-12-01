class Picture < ActiveRecord::Base
  attr_accessible :description, :name, :path, :picture
  mount_uploader :picture, PictureUploader
end
