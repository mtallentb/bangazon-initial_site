class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.references :customer, index: true, foreign_key:true, null: false
      t.references :product_type_id, index:true, foreign_key: true, null:false
      t.string :product_name, null:false
      t.decimal :product_price, precision: 6, scale: 2, null:false
      t.string :product_desc, null:false
      t.datetime :product_added, null:false
      t.string :product_location
      t.attachment :product_picture
      t.timestamps
    end
  end
end