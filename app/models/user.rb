class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :videos
  has_many :reactions
  has_many :video_reports
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  validates_uniqueness_of :username

  def generate_access_token
    self.update! api_token: SecureRandom.hex
    self.api_token
  end
end
