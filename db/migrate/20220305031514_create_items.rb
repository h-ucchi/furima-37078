class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title,                 null: false, default: ""
      t.text :description,             null: false #MySQLでは、textのdefault値の設定ができない
      t.integer :category_id,          null: false
      t.integer :item_condition_id,    null: false
      t.integer :area_id,              null: false
      t.integer :price,                null: false
      t.integer :delivery_day,          null: false, default: ""
      t.integer :delivery_cost_id,     null: false
      t.references :user,              null: false, foreign_key: true

      t.timestamps
    end
  end
end
