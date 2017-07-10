class Micropost < ApplicationRecord
  belongs_to :user

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size

  scope :order_desc, ->{order created_at: :DESC}
  scope :feeds, ->id do
    where "user_id IN (SELECT followed_id FROM relationships
      WHERE follower_id = #{id}) OR user_id = #{id}"
  end

  private

  def picture_size
    return if picture.size <= Settings.max_pic_size.megabytes
    errors.add :picture, t("capacity_mess")
  end
end
