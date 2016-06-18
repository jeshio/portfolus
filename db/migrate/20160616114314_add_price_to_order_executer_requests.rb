class AddPriceToOrderExecuterRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :order_executer_requests, :price, :integer
  end
end
