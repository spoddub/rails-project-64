# frozen_string_literal: true

# db/migrate/20250920231528_add_creator_ref_to_posts.rb
class AddCreatorRefToPosts < ActiveRecord::Migration[7.2]
  def up
    unless column_exists?(:posts, :creator_id)
      add_reference :posts, :creator, null: false, foreign_key: { to_table: :users }
    end

    return if foreign_key_exists?(:posts, :users, column: :creator_id)

    add_foreign_key :posts, :users, column: :creator_id
  end

  def down
    remove_foreign_key :posts, column: :creator_id if foreign_key_exists?(:posts, :users, column: :creator_id)
    return unless column_exists?(:posts, :creator_id)

    remove_reference :posts, :creator, foreign_key: true
  end
end
