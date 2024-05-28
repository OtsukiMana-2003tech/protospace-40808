class Prototype < ApplicationRecord
  # prototypeモデルのバリデーション
  validates :title, presence: :true
  validates :catch_copy, presence: :true
  validates :concept, presence: :true
  validates :image, presence: true

  # prototypeモデルのアソシエーション
  belongs_to :user
  has_many :comments, dependent: :destroy

  # 画像を保存できるようにする
  has_one_attached :image
end