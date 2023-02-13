class Picture < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user

  def favorite_users
    favorites = Favorite.where(picture_id: self.id, is_enabled: true)
    users = []
    favorites.each do |favorite|
      user = User.find_by(id: favorite.user_id)
      users.push user if user.present?
    end
    return users
  end

  def favorite_user_ids
    ids = []
    self.favorite_users.each do |user|
      ids.push user.id
    end
    return ids
  end

end
