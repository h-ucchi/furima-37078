class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title,                 null: false, default: ""
      t.text :description,             null: false, default: ""
      t.integer :category_id,          null: false, default: ""
      t.integer :item_condition_id,    null: false, default: ""
      t.integer :area_id,              null: false, default: ""
      t.integer :price,                null: false, default: ""
      t.integer :delivery_cost_id,     null: false, default: ""
      t.references :user,              null: false, foreign_key: true

      t.timestamps
    end
  end
end
