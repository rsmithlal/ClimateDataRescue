class AddElevationToPageInfo < ActiveRecord::Migration[5.2]
  def change
    return if column_exists?(:page_infos, :elevation)

    add_column :page_infos, :elevation, :string
  end
end
