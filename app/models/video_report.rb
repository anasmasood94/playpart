class VideoReport < ApplicationRecord
  belongs_to :video
  belongs_to :user
  validates_presence_of :reason
end
