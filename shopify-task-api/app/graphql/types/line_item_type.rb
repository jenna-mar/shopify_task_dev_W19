module Types
  class LineItemType < Types::BaseObject
    description "A line item in an order."
    field :id, ID, null: false
    field :title, String, null: false,
          description: "The name of the line item. This is the same as the title of its product on creation."
    field :quantity, Int, null: false,
          description: "The quantity of product purchased in the order."
    field :price, Float, null: true,
          description: "Price of the line item. When a line item is
        created, it is given the price of its product."
    field :order, OrderType, null: false,
          description: "The line item's order."
    field :product, ProductType, null: false,
          description: "The line item's product."
  end
end
