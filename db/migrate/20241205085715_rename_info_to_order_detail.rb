class RenameInfoToOrderDetail < ActiveRecord::Migration[7.2]
  def change
    rename_table :infos, :order_details
  end
end
