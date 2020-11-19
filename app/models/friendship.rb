class Friendship < ApplicationRecord
  belongs_to :friender, class_name: "User", foreign_key: :friender_id
  belongs_to :friendee, class_name: "User", foreign_key: :friendee_id

  validates :friender_id, presence: true
  validates :friendee_id, presence: true

end
