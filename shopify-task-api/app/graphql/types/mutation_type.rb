module Types
  class MutationType < Types::BaseObject
    description "Available root mutations"

    #mutations for shop create/update/destroy operations
    field :create_shop, ShopType, null: false do
      description "Create a new shop"
      argument :name, String, required: true
    end

    field :edit_shop, ShopType, null: false do
      description "Update a shop's name"
      argument :id, ID, required: true, description: "The ID of the shop to be edited"
      argument :name, String, required: true, description: "The new name of the shop"
    end

    field :delete_shop, ShopType, null: false do
      description "Delete a shop. Warning: this will delete all of a shop's products and orders too!"
      argument :id, ID, required: true, description: "The ID of the shop to be deleted"
    end

    #mutations for product create/update/destroy operations
    field :create_product, ProductType, null: false do
      description "Create a new product."
      argument :title, String, required: true,
            description: "The product's name."
      argument :description, String, required: false,
            description: "A description of the product."
      argument :price, Float, required: true,
            description: "The price in dollars of the product."
      argument :category, String, required: false,
            description: "The category of the product."
      argument :shop_id, ID, required: true,
            description: "The ID of the shop that the product belongs to."
    end

    field :edit_product, ProductType, null: false do
      description "Update a product."
      argument :id, ID, required: true, description: "The ID of the product to be edited."
      argument :title, String, required: false, description: "The new name of the product."
      argument :description, String, required: false, description: "The new description of the product."
      argument :price, Float, required: false, description: "The new price of the product."
      argument :category, String, required: false, description: "The new category of the product."
      argument :shop_id, ID, required: false, description: "The product's new shop."
    end

    field :delete_product, ProductType, null: false do
      description "Delete a product. Warning: this will delete all of a product's line items too!"
      argument :id, ID, required: true, description: "The ID of the product to be deleted"
    end

    #mutations for order create/update/destroy operations
    field :create_order, OrderType, null: false do
      description "Create a new order."
      argument :shop_id, ID, required: true, description: "The ID of the shop that the order is from."
    end

    field :edit_order, OrderType, null: false do
      description "Edit an order."
      argument :id, ID, required: true, description: "The ID of the order to be edited."
      argument :total_price, Float, required: false, description: "The total price in dollars of the order."
      argument :shop_id, ID, required: false, description: "The ID of the shop that the order is from."
    end

    field :delete_order, OrderType, null: false do
      description "Delete an order. Warning: this will delete all of the order's line items."
      argument :id, ID, required: true, description: "The ID of the order to be deleted."
    end

    #mutations for line item create/update/destroy operations
    field :create_line_item, LineItemType, null: false do
      description "Create a new line item. Creating a new line item will also add its total cost to its order.
        The order and product IDs given must be from the same shop."
      argument :quantity, Int, required: true, description: "The quantity of the item purchased in the order."
      argument :order_id, ID, required: true, description: "The ID of the order that the line item is part of."
      argument :product_id, ID, required: true, description: "The ID of the product that the line item represents."
    end

    field :edit_line_item, LineItemType, null: false do
      description "Edit a line item. If the line item is a given a new product ID,
      the title and price will be updated to match. Otherwise, the provided title and price will take precedence,
      but the product ID will still be updated if present. The order total will also be adjusted to reflect changes in price, if applicable.
      The order and product IDs must be from the same shop."
      argument :id, ID, required: true, description: "The ID of the line item to be edited."
      argument :title, String, required: false, description: "The new title name of the line item."
      argument :quantity, Int, required: false, description: "The new quantity of the line item."
      argument :price, Float, required: false, description: "The new price of the line item."
      argument :order_id, ID, required: false, description: "The new order that the line item is part of."
      argument :product_id, ID, required: false, description: "The new product that the line item represents."
    end

    field :delete_line_item, LineItemType, null: false do
      description "Delete a line item. The value of the line item will be removed from its order (total price) upon deletion."
      argument :id, ID, required: true, description: "The ID of the line item to be deleted."
    end

    #implementations
    def create_shop(name:)
      Shop.create!(
          name: name
      )
    end

    def edit_shop(id:, name:)
      shop = Shop.find(id)
      shop.update(name: name)
      shop
    end

    def delete_shop(id:)
      shop = Shop.find(id)
      shop.destroy
      #return shop
      shop
    end

    def create_product(title:, price:, shop_id:, description: "", category: "")
      Product.create!(
          title: title,
          description: description,
          price: price,
          category: category,
          shop: Shop.find(shop_id)
      )
    end

    def edit_product(id:, title: nil, description: nil, price: nil, category: nil, shop_id: nil)
      product = Product.find(id)

      if shop_id
        product.update!(
            shop: Shop.find(shop_id)
        )
      end
      #only update attributes that aren't null
      product.update!(
          {
          title: title,
          description: description,
          price: price,
          category: category
          }.reject{|k,v| v.blank?}
      )
      product
    end

    def delete_product(id:)
      product = Product.find(id)
      product.destroy
      #return product
      product
    end

    def create_order(shop_id:)
      Order.create!(
          total_price: 0, #price should be 0 on creation because there are no line items
          shop: Shop.find(shop_id)
      )
    end

    def edit_order(id:, total_price: nil, shop_id: nil)
      order = Order.find(id)

      if shop_id
        order.update!(
            shop: Shop.find(shop_id)
        )
      end

      if total_price
        order.update!(
               total_price: total_price
        )
      end
      #return newly edited order
      order
    end

    def delete_order(id:)
      order = Order.find(id)
      order.destroy
      #return order
      order
    end

    def create_line_item(quantity:, order_id:, product_id:)
      product = Product.find(product_id)
      order = Order.find(order_id)
      if product.shop != order.shop
        raise GraphQL::ExecutionError, "Product ID #{product_id} and Order ID #{order_id} are not from the same shop, please check your input."
      end
      line_item = LineItem.create!(
          title: product.title,
          quantity: quantity,
          price: product.price,
          order: order,
          product: product
      )

      #update order total too
      total_price = order.total_price + line_item.price * quantity
      order.update!(
          total_price: total_price
      )

      line_item
    end

    def edit_line_item(id:, title: nil, quantity: nil, price: nil, order_id: nil, product_id: nil)
      line_item = LineItem.find(id)
      #save the old price and quantity to use later if needed
      price_old = line_item.price
      quantity_old = line_item.quantity

      if order_id && product_id #check if both shop and order are from the same shop
        if Product.find(product_id).shop != Order.find(order_id).shop
          raise GraphQL::ExecutionError, "Product ID #{product_id} and Order ID #{order_id} are not from the same shop, please check your input."
        end
      end

      if order_id
        if line_item.product.shop != Order.find(order_id).shop
          raise GraphQL::ExecutionError, "Product ID #{line_item.product.id} and Order ID #{order_id} are not from the same shop, please check your input."
        end
        #remove line item's cost from old order
        total_price = line_item.order.total_price - line_item.price * line_item.quantity
        line_item.order.update!( total_price: total_price )
        line_item.update!(
            order: Order.find(order_id)
        )
      end

      if product_id
        if Product.find(product_id) != line_item.order.shop
          raise GraphQL::ExecutionError, "Product ID #{product_id} and Order ID #{line_item.order.id} are not from the same shop, please check your input."
        end
        product = Product.find(product_id)
        line_item.update!(
            title: product.title,
            price: product.price,
            product_id: product
        )
      end

      line_item.update!(
         {
          title: title,
          quantity: quantity,
          price: price,
         }.reject{|k,v| v.blank?}
      )

      total_price = line_item.order.total_price

      if order_id #if order changed, just add new price(if applicable) to total cost
        total_price += line_item.price * line_item.quantity
        line_item.order.update!( total_price: total_price )
      elsif price || quantity || product_id #order didn't change, but price, quantity or product did
        total_price -= price_old * quantity_old
        total_price += line_item.price * line_item.quantity
        line_item.order.update!( total_price: total_price )
      end

      #return newly edited line item
      line_item
    end

    def delete_line_item(id:)
      line_item = LineItem.find(id)
      #update order to not include line item's price anymore
      total_price = line_item.order.total_price - line_item.price * line_item.quantity
      line_item.order.update!( total_price: total_price )

      line_item.destroy
      #return line item
      line_item
    end

  end
end
