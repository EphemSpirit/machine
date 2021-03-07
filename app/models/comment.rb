class Comment < ApplicationRecord
  belongs_to :commenter, class_name: "User", foreign_key: :commenter_id
  belongs_to :commented_post, class_name: "Post", foreign_key: :commented_post_id

  validates :body, presence: true

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
end
