class Profile < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_one_attached :profile_pic

  #validations
  validates :bio, length: { maximum: 250 }
  validates :profile_pic, content_type: { in: %w[image/jpeg image/png] },
                          size: { less_than: 5.megabytes }

  #image resizing
  def display_image
    profile_pic.variant(resize_to_limit: [200, 200])
  end

end
