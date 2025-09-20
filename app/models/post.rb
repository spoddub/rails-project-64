class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: "User"
  validates :title, presence: true, length: { maximum: 200 }
  validates :body, presence: true
end
