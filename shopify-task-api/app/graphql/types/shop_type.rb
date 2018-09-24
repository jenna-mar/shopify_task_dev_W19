module Types
  class ShopType < Types::BaseObject
    description "A shopfront."
    field :id, ID, null: false
    field :name, String, null: false,
      description: "The name of the shop."
    field :orders, [OrderType], null: true,
          description: "The shop's orders."
    field :products, [ProductType], null: true,
          description: "The shop's products."
  end
end
