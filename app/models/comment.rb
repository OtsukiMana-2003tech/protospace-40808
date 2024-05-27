class Comment < ApplicationRecord
  # commentsモデルのバリデーション
  validates :content, presence: :true

  # commentsモデルのアソシエーション
  belongs_to :user
  belongs_to :prototype
end
