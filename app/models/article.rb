class Article < ApplicationRecord
  has_many :comments
  has_many_attached :avatars
  has_many_attached :video_files
end
