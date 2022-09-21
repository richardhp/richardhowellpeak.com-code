class RemoveColFromBlogPosts < ActiveRecord::Migration[6.0]
  def change

    remove_column :blog_posts, :title, :string
    remove_column :blog_posts, :text, :string
    add_column :blog_posts, :document_id, :integer
  end
end
