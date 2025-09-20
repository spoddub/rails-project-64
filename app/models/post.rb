# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: "User"
  validates :title, presence: true
  validates :body,  presence: true
end
