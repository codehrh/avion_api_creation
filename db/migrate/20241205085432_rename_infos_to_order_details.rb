class RenameInfosToOrderDetails < ActiveRecord::Migration[7.2]
  def change
    # this was not migrated, saved after migration
    rename_table :infos, :order_details
  end
end
