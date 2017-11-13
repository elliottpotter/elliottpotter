class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :email
      t.string :phone_number
      t.string :instagram_username
      t.string :instagram_password

      t.timestamps
    end
  end
end
