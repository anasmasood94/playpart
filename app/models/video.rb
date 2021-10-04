class Video < ApplicationRecord
  belongs_to :user
  has_one_attached :video
  has_many :reactions

  scope :with_list_order, -> { includes(:reactions).order(updated_at: :desc).with_attached_video }
end
