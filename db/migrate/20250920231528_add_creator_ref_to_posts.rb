# db/migrate/20250920231528_add_creator_ref_to_posts.rb
class AddCreatorRefToPosts < ActiveRecord::Migration[7.2]
  def up
    unless column_exists?(:posts, :creator_id)
      add_reference :posts, :creator, null: false, foreign_key: { to_table: :users }
    end

    unless foreign_key_exists?(:posts, :users, column: :creator_id)
      add_foreign_key :posts, :users, column: :creator_id
    end
  end

  def down
    if foreign_key_exists?(:posts, :users, column: :creator_id)
      remove_foreign_key :posts, column: :creator_id
    end
    if column_exists?(:posts, :creator_id)
      remove_reference :posts, :creator, foreign_key: true
    end
  end
end
