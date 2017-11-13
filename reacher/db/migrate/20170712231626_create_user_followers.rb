class CreateUserFollowers < ActiveRecord::Migration[5.0]
  def change
    create_table :user_followers do |t|
      t.references :user, foreign_key: true
      t.integer :new_followers

      t.timestamps
    end
  end
end
