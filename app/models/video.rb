class Video < ApplicationRecord
  belongs_to :user
  has_one_attached :video
  has_many :reactions
end
