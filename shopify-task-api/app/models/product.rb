# Table name: products
#
#  id           :integer(4)      not null, primary key
#  title        :string(255)     default("")
#  description  :text
#  price        :decimal(10,2)   not null, default(0.0)
#  category     :string(255)
#  shop_id      :integer(4)      foreign key
#  created_at   :datetime
#  updated_at   :datetime
#

class Product < ApplicationRecord
  belongs_to :shop
  has_many :line_items, dependent: :destroy

  validates_presence_of :title, :price
end
