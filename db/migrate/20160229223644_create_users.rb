class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :uid
      t.string :provider
      t.string :email
      t.string :token
      t.string :first_name
      t.string :last_name
      t.string :image_url

      t.timestamps null: false
    end
  end
end
