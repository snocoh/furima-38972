class Item < ApplicationRecord
  validates :goods, presence: true
  validates :content, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :postage_id, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_day_id, presence: true

  validates :price, presence: true, format: { with: /\A[0-9]+\z/ }, 
             numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  belongs_to :user
  has_one    :order
  has_one_attached :image

  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
end
