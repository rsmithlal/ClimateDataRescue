class AddDefaultValueToFields < ActiveRecord::Migration[5.2]
  def change
    add_column :fields, :default_value, :string, default: '', null: false
  end
end
