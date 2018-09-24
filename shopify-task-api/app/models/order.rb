# Table name: orders
#
#  id                       :integer(4)      not null, primary key
#  total_price              :decimal(10, 2)  not null, default(0.0)
#  shop_id                  :integer(4)
#  created_at               :datetime
#  updated_at               :datetime
#

class Order < ApplicationRecord
  belongs_to :shop
  has_many :line_items, dependent: :destroy

  validates_presence_of :total_price
end
