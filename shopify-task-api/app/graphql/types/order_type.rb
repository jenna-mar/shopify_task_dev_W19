module Types
  class OrderType < Types::BaseObject
    description "A shop order."
    field :id, ID, null: false
    field :total_price, Float, null: false,
          description: "Total price of the order. This is the total sum of all its line items."
    field :shop, ShopType, null: false,
          description: "The shop that the order was made from."
    field :line_items, [LineItemType], null: true,
          description: "This order's line items."
  end
end
