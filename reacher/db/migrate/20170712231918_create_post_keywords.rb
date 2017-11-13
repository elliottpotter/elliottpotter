class CreatePostKeywords < ActiveRecord::Migration[5.0]
  def change
    create_table :post_keywords do |t|
      t.references :instagram_post, foreign_key: true
      t.string :word
      t.string :part_of_speech

      t.timestamps
    end
  end
end
