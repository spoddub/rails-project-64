# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: "User"
  has_many :post_comments, dependent: :destroy
  validates :title, :body, presence: true
  has_many :post_likes, dependent: :destroy
  has_many :likers, through: :post_likes, source: :user
end
