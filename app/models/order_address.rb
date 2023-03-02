class OrderAddress
  include ActiveModel::Model
  attr_accessor :postcode, :prefecture_id, :city, :street, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :prefecture_id, numericality: { other_than: 1}
    validates :city
    validates :street
    validates :phone_number, numericality: {only_integer: true}, length: {minimum: 10, maximum: 11}
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postcode: postcode, prefecture_id: prefecture_id, city: city, street: street, building: building, phone_number: phone_number, order_id: order.id)
  end
end