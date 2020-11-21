class Profile < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_one_attached :profile_pic

  after_create :send_thank_you

  #validations
  validates :bio, length: { maximum: 50 }
  validates :profile_pic, content_type: { in: %w[image/jpeg image/png] },
                          size: { less_than: 5.megabytes }

  #image resizing
  def display_image
    profile_pic.variant(resize_to_limit: [200, 200])
  end

  def show_image
    profile_pic.variant(resize_to_limit: [80, 80])
  end

  #profile feed
  def feed
    @feed_posts = all_friends(self.owner)
  end

  private

    def send_thank_you
      UserMailer.thank_you(self.owner).deliver_now!
    end

end
