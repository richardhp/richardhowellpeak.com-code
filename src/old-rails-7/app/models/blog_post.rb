class BlogPost < ApplicationRecord
  has_many :blog_post_categories
  has_many :categories, class_name: 'Admin::BlogCategory', through: :blog_post_categories, source: :blog_category
  
  belongs_to :document, class_name: "Admin::Document", :foreign_key => "document_id"
  
  accepts_nested_attributes_for :categories

  # Only fetch published articles
  def self.published
    where(published: true).order(published_at: :desc)
  end
  # Filter by category
  def self.category_filter(category_name)
    joins(:categories).where("admin_blog_categories.title = ? ", category_name)
  end

end
