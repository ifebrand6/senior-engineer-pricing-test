class UpdateOrderProductsWithProductPrice < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
      dir.up do
        OrderProduct.reset_column_information
        OrderProduct.includes(:product).find_each do |order_product|
          order_product.update(price: order_product.product.price_in_cents)
        end
      end

      dir.down { OrderProduct.find_each { |order_product| order_product.update(price: nil) } }
    end
  end
end
