require 'net/http'

class BlogsController < ApplicationController

  def show
    @theme = "default"
    @category = params[:category]
    @categories = Admin::BlogCategory.all
    @blog_posts = BlogPost.published
    @blog_posts = @blog_posts.category_filter(params[:category]) if params[:category].present?
    @blog_posts = @blog_posts.paginate(page: params[:page], per_page: 4)
  end
  
  def view_article
    puts params
    @theme = "default"
    @blog_post = BlogPost.find_by(slug: params[:slug] )
    if @blog_post.nil?
      render "article_not_found"
    end
  end

  def podcast
    xml_feed_url = URI('https://feed.podbean.com/richardhpeak/feed.xml')
    xml_feed = Net::HTTP.get(xml_feed_url)
    @hash_feed = Hash.from_xml(xml_feed)["rss"]
    @podcast_url = @hash_feed["channel"]["link"].last
    @episodes = @hash_feed["channel"]["item"]
  end

end