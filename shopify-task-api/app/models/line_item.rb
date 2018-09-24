# Table name: line_items
#
#  id                  :integer      not null, primary key
#  title               :string       not null, default("")
#  quantity            :integer      not null, default(0)
#  price               :decimal      default(0.0)
#  order_id            :integer      foreign key
#  product_id          :integer      foreign key
#  created_at          :datetime
#  updated_at          :datetime
#

# Line items refer to any service or product added to an order, along with the quantity and price
# that pertain to them.
# The value of a Line Item should be the same as the value of the Product that the Line Item represents.
# It is a copy of the value of the product on its creation.

class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, :numericality => { :greater_than_or_equal_to => 0 }
  validates_presence_of :title, :quantity, :price
end
