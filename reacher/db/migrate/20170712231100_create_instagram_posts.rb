class CreateInstagramPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :instagram_posts do |t|
      t.string :url
      t.string :short_url
      t.string :image_url

      t.timestamps
    end
  end
end
