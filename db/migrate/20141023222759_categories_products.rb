class CategoriesProducts < ActiveRecord::Migration
  def change
  	  create_table :categories_products, :id => false do |t|
      t.integer :category_id
      t.integer :product_id
      t.timestamps
  end
  end
end
