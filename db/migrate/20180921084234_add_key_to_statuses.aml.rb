# This migration comes from aml (originally 20180921081808)
class AddKeyToStatuses < ActiveRecord::Migration[5.2]
  def up
    add_column :aml_statuses, :key, :string

    AML::Status.find_each do |a|
      a.update key: Random.hex
    end

    change_column_null :aml_statuses, :key, false

    add_index :aml_statuses, :key, unique: true
  end

  def down
    remove_column :aml_statuses, :key
  end
end
