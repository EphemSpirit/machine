class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  has_many :likings, foreign_key: :liked_post_id
  has_many :likers, through: :likings
  has_one_attached :post_img

  default_scope ->{ order(created_at: :desc) }

  validates :body, presence: true
  validates :author_id, presence: true

  def display_post_image
    post_img.variant(resize_to_limit: [200, 200])
  end

  def has_likers?
    self.likers.any?
  end

  def num_likes
    self.likers.count
  end

  def has_liked?(user)
    self.likers.include?(user)
  end

end
