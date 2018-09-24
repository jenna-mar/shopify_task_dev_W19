# This will populate the database with some dummy data.
# to run: `bundle exec rails db:seed`

# clear out existing data
[LineItem, Product, Order, Shop].each do |model|
  model.delete_all
end

# create some shops
shops = Array(1..5).map do |n|
  Shop.create!(
      name: "Example Store #{n}"
  )
end

puts "Created some shops."

# create some products
products = Array(1..50).map do |n|
  Product.create!(
      title: "#{['Wonder', 'Wet', 'Simple', 'Modern'].sample} #{['Bread', 'Umbrella', 'Milk'].sample}",
      description: "This is a #{['cool', 'must have','trendy'].sample} item.",
      price: [1.00, 9.99, 5.99, 20.00].sample,
      category: "#{['Pantry', 'Accessories'].sample}",
      shop: shops.sample
  )
end
puts "Created some products."

# create some orders
orders = Array(1..20).map do |n|
  Order.create!(
      total_price: 0,
      shop: shops.sample
  )
end
puts "Created some orders."

#give each order at least one line item
Array(0..19).each do |n|
  #get products from the shop that the order is from
  shop_products = orders[n].shop.products

  line_item = LineItem.create!(
      quantity: [1,2,3,4,5].sample,
      order: orders[n],
      product: shop_products.sample
  )

  line_item.title = line_item.product.title
  line_item.price = line_item.product.price * line_item.quantity
  line_item.save!

  #update order total
  orders[n].total_price += line_item.price
  orders[n].save!
end


#add more line items to orders
Array(1..40).each do |n|
  #get a random order to add more line items to, and its shop
  order = orders.sample
  shop_products = order.shop.products

  #ensure item hasn't been added already
  order_products = []
  LineItem.where(order:order).map do |i|
    order_products.push(i.product)
  end
  product = shop_products.sample

  unless product.in?(order_products)
    line_item = LineItem.create!(
        title: product.title,
        quantity: [1,2,3,4,5].sample,
        order: order,
        product: product
    )

    line_item.price = line_item.product.price * line_item.quantity
    line_item.save!

    order.total_price += line_item.price
    order.save!
  end
end

puts "Created some line items."



