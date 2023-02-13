class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }
  mount_uploader :avatar, AvatarUploader
  has_many :pictures, dependent: :destroy

  def favorite_pictures
    favorites = Favorite.where(user_id: self.id, is_enabled: true)
    pictures = []
    favorites.each do |favorite|
      picture = Picture.find_by(id: favorite.picture_id)
      pictures.push picture if picture
    end
    return pictures
  end
end
