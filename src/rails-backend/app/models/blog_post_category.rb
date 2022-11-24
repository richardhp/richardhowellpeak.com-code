class BlogPostCategory < ApplicationRecord
  belongs_to :blog_category, class_name: "Admin::BlogCategory"
  has_one :blog_post
end