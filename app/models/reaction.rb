class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :video
  validates_presence_of :reaction
  validates_uniqueness_of :video_id, scope: :user_id
end
