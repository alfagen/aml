# This migration comes from aml (originally 20181121073548)
class AddClonedOrderIdToOrsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :aml_orders, :cloned_order, foreign_key: { to_table: :aml_orders }
  end
end
