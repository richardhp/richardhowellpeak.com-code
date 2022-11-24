class AddMediumToBlogPost < ActiveRecord::Migration[6.0]
  def change
    add_column :blog_posts, :medium_url, :string
  end
end
