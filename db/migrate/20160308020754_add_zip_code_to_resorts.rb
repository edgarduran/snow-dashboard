class AddZipCodeToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :zip_code, :string
  end
end
