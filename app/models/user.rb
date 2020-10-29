class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #associations
  has_many :requests
  has_many :pending_friends, through: :requests, source: :receiver
  has_many :inverse_requests, class_name: "Request", foreign_key: :receiver_id
  has_many :friendships
  has_many :friends, through: :friendships, source: :friendee
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friendee_id

  #email regex
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #validations
  validates :name, presence: true
  validates :email, presence: true, format: { with: EMAIL_REGEX }
  validates :username, presence: true, length: { in: 6..20 }
  validates :username, uniqueness: true

  def num_requests
    Request.where("receiver_id = ? AND accepted = ?", self.id, nil).size
  end

  def is_friend?
    Friendship.where("friender_id = ? OR friendee_id = ?", self.id, self.id).any?
  end

end
