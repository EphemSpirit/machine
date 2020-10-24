class Request < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :sender, presence: true
  validates :receiver, presence: true
end
