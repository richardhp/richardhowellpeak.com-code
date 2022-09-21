class AddColToBlogPost < ActiveRecord::Migration[6.0]
  def change
    add_column :blog_posts, :published, :boolean
    add_column :blog_posts, :text, :string
  end
end
