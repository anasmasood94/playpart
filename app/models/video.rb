class Video < ApplicationRecord
  belongs_to :user
  has_many :reactions

  scope :with_list_order, -> { includes(:reactions).order(updated_at: :desc) }
end
