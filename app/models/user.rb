class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #callbacks
  after_create :build_profile
  #after_save :send_thank_you

  #associations
  has_many :requests
  has_many :pending_friends, through: :requests, source: :receiver
  has_many :inverse_requests, class_name: "Request", foreign_key: :receiver_id
  has_many :friendships
  has_many :friends, through: :friendships, source: :friendee
  has_many :inverse_friends, class_name: "Friendship", foreign_key: :friendee_id
  has_one :profile
  has_many :posts, foreign_key: :author_id
  has_many :likes
  has_many :likings, foreign_key: :liker_id
  has_many :liked_posts, through: :likings, source: :liker
  has_many :comments, foreign_key: :commenter_id

  #email regex
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #validations
  validates :email, presence: true, format: { with: EMAIL_REGEX }
  validates :username, presence: true, length: { in: 6..20 }
  validates :username, uniqueness: true
  validates :name, presence: true

  def num_requests
    Request.where("receiver_id = ? AND accepted IS NULL", self.id).size
  end

  def feed_posts
    user_friends = self.friends.pluck(:id) + self.inverse_friends.map(&:friender).pluck(:id)
    Post.where(author: [user_friends]).or(Post.where(author: self))
  end

  private

    def build_profile
      Profile.create(user_id: self.id)
    end

    # def send_thank_you
    #   UserMailer.thank_you(self).deliver_now!
    # end

end
