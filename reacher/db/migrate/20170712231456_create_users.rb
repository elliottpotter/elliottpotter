class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.references :client, foreign_key: true
      t.string :profile_url

      t.timestamps
    end
  end
end
