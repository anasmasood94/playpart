class Video < ApplicationRecord
  belongs_to :user
  has_many :reactions
  has_many :video_reports, dependent: :destroy

  scope :with_list_order, ->(user_id) {
    includes(:reactions, :user).
    joins("LEFT JOIN video_reports ON video_reports.video_id = videos.id").
    where("video_reports.id IS NULL").
    order(updated_at: :desc)
  }
end
