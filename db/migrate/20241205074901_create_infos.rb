class CreateInfos < ActiveRecord::Migration[7.2]
  def change
    create_table :infos do |t|
      t.string :item
      t.integer :quantity
      t.string :address
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
