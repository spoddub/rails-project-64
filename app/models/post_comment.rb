class PostComment < ApplicationRecord
  has_ancestry ancestry_format: :materialized_path2

  belongs_to :post
  belongs_to :user

  validates :content, presence: true
end
