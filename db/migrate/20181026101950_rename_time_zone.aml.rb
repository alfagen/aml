# This migration comes from aml (originally 20181026101822)
class RenameTimeZone < ActiveRecord::Migration[5.2]
  def change
    rename_column :aml_operators, :time_zone, :time_zone_name
  end
end
