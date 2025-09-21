class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: "User"

  has_many :comments, class_name: "PostComment", dependent: :destroy
  has_many :post_comments, class_name: "PostComment"

  has_many :post_likes, dependent: :destroy
  has_many :likers, through: :post_likes, source: :user

  validates :title, :body, presence: true
end
