# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: 'User'

  has_many :post_comments, dependent: :destroy
  has_many :comments, class_name: 'PostComment', dependent: :destroy

  has_many :post_likes, dependent: :destroy
  has_many :likers, through: :post_likes, source: :user
  has_many :likes, class_name: 'PostLike', dependent: :destroy

  validates :title, :body, presence: true
end
