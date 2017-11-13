class AddUserToInstagramPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :instagram_posts, :user, foreign_key: true
  end
end
