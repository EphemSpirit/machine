class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  has_one_attached :post_img

  default_scope ->{ order(created_at: :desc) }

  validates :body, presence: true
  validates :author_id, presence: true

  def display_post_image
    post_img.variant(resize_to_limit: [200, 200])
  end

end
