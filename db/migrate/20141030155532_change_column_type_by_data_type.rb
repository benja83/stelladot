class ChangeColumnTypeByDataType < ActiveRecord::Migration
  def change
    remove_column :config_settings, :type
    add_column :config_settings, :data_type, :string
  end
end
