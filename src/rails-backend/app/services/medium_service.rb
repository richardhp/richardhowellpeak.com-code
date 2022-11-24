require 'medium_sdk'

class MediumService

  include BlogPostsHelper

  # Initialize SDK
  def initialize
    @token = ENV["medium_api_token"]
    @client = MediumSdk.new integration_token: @token
    @client.connection.token = @token
  end

  def publish_draft(blog_post)
    options = {
      title: blog_post.document.title,
      contentFormat: "html",
      content: blog_post_to_hmtl(blog_post),
      publishStatus: "draft"
    }
    if blog_post.blog_post_categories.count > 0
      options[:tags] = blog_post.blog_post_categories.map { |category| category.blog_category.title }
    end
    @client.post(options)
  end

  def blog_post_to_hmtl(blog_post, theme = "default")
    render_method("blogs/themes/medium", { blog_post: blog_post }) 
  end

end

