class ContentImage < ApplicationRecord
  Paperclip.interpolates :image_file_name do |attachment, style|
    attachment.instance.image_file_name
  end
  has_attached_file :image,
                styles: { 
                  thumb: ["64x64#"],
                  small: ["200x200>"],
                  medium: ["400x400>"],
                  large: ["600x600>"],
                  xlarge: ["1000x1000>"]
                },
                default_style: :medium,
                url: "/uploads/:class/:style/:image_file_name"
  validates_attachment :image,
                      presence: true,
                      content_type: { :content_type => /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/, :message => 'file type is not allowed (only jpeg/png/gif images)' }

  def name
    name = read_attribute(:name)
    image_file_name unless name.present?

    name
  end
end
