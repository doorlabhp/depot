class CombineItemsInCart < ActiveRecord::Migration
  def self.up
    Cart.all.each do |cart|
      sums=cart.line_items.group(:product_id).sum(:quantity)
      sums.each do |product_id, sum|
        cart.line_items.where(:product_id => product_id).delete_all
        cart.line_items.build(:product_id => product_id, :quantity => sum)
      end
        
    end
  end

  def self.down
    # split items with quantity>1 into multiple items
    LineItem.where("quantity>1").each do |line_item|
    # add individual items
      line_item.quantity.times do
        LineItem.create :cart_id=>line_item.cart_id,:product_id=>line_item.product_id, :quantity=>1
      end
      line_item.destroy
    end
    
  end

end
