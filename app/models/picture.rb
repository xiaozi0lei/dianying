class Picture < ActiveRecord::Base
  # mount_uploader method must be called before after_save method.
  mount_uploader :picture, PictureUploader
  after_save :get_picture_url
  attr_accessible :description, :name, :path, :picture

  private

    def get_picture_url
      # for openshift begin
      self.picture_url(:thumb) =~ /data/
      File.symlink(self.picture_url(:thumb),"#{Rails.root}/public#{$'}")
      # for openshift end
      #self[:path] = self.picture_url(:thumb)
    end

end
