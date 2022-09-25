class CreateAdminBlogCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_blog_categories do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
