module Types
  class ProductType < Types::BaseObject
    description "A shop product."
    field :id, ID, null: false
    field :title, String, null: false,
          description: "The product's name."
    field :description, String, null: true,
      description: "A text description of the product."
    field :price, Float, null: true,
          description: "The price in dollars of the product."
    field :category, String, null: true,
            description: "The category of the product."
    field :shop, ShopType, null: false,
          description: "The shop that the product belongs to."
    field :line_items, [LineItemType], null: true,
          description: "All of this product's line items."
  end
end
