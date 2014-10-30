class CreateConfigSettings < ActiveRecord::Migration
  def change
    create_table :config_settings do |t|
      t.string :name
      t.string :value
      t.string :type
      t.timestamps
    end
  end
end
