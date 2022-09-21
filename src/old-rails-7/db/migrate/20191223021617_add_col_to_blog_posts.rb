class AddColToBlogPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :blog_posts, :slug, :text
    add_column :blog_posts, :published_at, :datetime
  end
end
