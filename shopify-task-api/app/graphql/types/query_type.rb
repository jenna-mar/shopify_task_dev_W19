module Types
  class QueryType < Types::BaseObject
    description "The query root of this schema"

    #Shop general queries
    field :shop, ShopType, null: false do
      description "Find a Shop by ID"
      argument :id, ID, required: true
    end

    field :shops, [ShopType], null: false do
      description "A list of all Shops."
    end

    #Product queries
    field :product, ProductType, null: false do
      description "Find a Product by ID"
      argument :id, ID, required: true
    end

    field :products, [ProductType], null: false do
      description "A list of all Products."
    end

    #Order queries
    field :order, OrderType, null: false do
      description "Find a Order by ID"
      argument :id, ID, required: true
    end

    field :orders, [OrderType], null: false do
      description "A list of all Orders."
    end

    #Line Item queries
    field :line_item, LineItemType, null: false do
      description "Find a Line Item by ID."
      argument :id, ID, required: true
    end

    field :line_items, [LineItemType], null:false do
      description "A list of all Line Items."
    end

    # Implementations:
    def shop(id:)
      Shop.find(id)
    end

    def shops
      Shop.all
    end

    def product(id:)
      Product.find(id)
    end

    def products
      Product.all
    end

    def order(id:)
      Order.find(id)
    end

    def orders
      Order.all
    end

    def line_item(id:)
      LineItem.find(id)
    end

    def line_items
      LineItem.all
    end
  end
end