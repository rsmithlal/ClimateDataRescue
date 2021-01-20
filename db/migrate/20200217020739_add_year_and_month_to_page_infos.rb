class AddYearAndMonthToPageInfos < ActiveRecord::Migration[5.2]
  def change
    return if column_exists?(:page_infos, :month) && column_exists?(:page_infos, :year)

    add_column :page_infos, :month, :integer
    add_column :page_infos, :year, :integer
  end
end
