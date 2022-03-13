class CreateShippingAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :post_code,          null: false, default: ""
      t.references :area_id,        null: false, foreign_key: true
      t.string :municipality,       null: false, default: ""
      t.string :address,            null: false, default: ""
      t.string :building_name,                   default: ""
      t.string :tell_number,                     default: ""
      t.references :order,          null: false, foreign_key: true

      t.timestamps
    end
  end
end