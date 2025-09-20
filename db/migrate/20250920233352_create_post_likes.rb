class CreatePostLikes < ActiveRecord::Migration[7.2]
  def change
    create_table :post_likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end

    add_index :post_likes, [ :post_id, :user_id ], unique: true
  end
end
