class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :videos
  has_many :reactions
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  def generate_access_token
    self.update! api_token: SecureRandom.hex
    self.api_token
  end
end
