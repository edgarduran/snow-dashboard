class ChangeLatAndLongToDecimal < ActiveRecord::Migration
  def change
    change_column :resorts, :latitude, :decimal, precision: 9, scale: 6
    change_column :resorts, :longitude, :decimal, precision: 9, scale: 6
  end
end
