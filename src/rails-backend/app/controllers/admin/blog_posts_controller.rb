class Admin::BlogPostsController < Admin::AdminController
  before_action :require_login
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]

  def publish_to_medium
    blog_post = BlogPost.find(params[:blog_post_id])
    medium_service = MediumService.new
    @response = medium_service.publish_draft(blog_post)
    # redirect_to 
  end

  # GET /blog_posts
  # GET /blog_posts.json
  def index
    @blog_posts = BlogPost.all
  end

  # GET /blog_posts/1
  # GET /blog_posts/1.json
  def show
  end

  # GET /blog_posts/new
  def new
    @blog_post = BlogPost.new
  end

  # GET /blog_posts/1/edit
  def edit
  end

  # POST /blog_posts
  # POST /blog_posts.json
  def create
    @blog_post = BlogPost.new(blog_post_params)

    respond_to do |format|
      if @blog_post.save
        # Create Category Links
        @blog_post.categories = Admin::BlogCategory.where( id: params[:blog_post][:categories].reject(&:empty?) )
        @blog_post.save!

        format.html { redirect_to [:admin, @blog_post], notice: 'Blog post was successfully created.' }
        format.json { render :show, status: :created, location: @blog_post }
      else
        format.html { render :new }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blog_posts/1
  # PATCH/PUT /blog_posts/1.json
  def update
    respond_to do |format|
      if @blog_post.update(blog_post_params)
        # Update Category Links
        @blog_post.categories = Admin::BlogCategory.where( id: params[:blog_post][:categories].reject(&:empty?) )
        @blog_post.save!

        format.html { redirect_to [:admin, @blog_post], notice: 'Blog post was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog_post }
      else
        format.html { render :edit }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_posts/1
  # DELETE /blog_posts/1.json
  def destroy
    @blog_post.destroy
    respond_to do |format|
      format.html { redirect_to admin_blog_posts_url, notice: 'Blog post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog_post
      @blog_post = BlogPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_post_params
      # params[:blog_post][:categories] = params[:blog_post][:categories].delete("")
      params.require(:blog_post).permit(:document_id, :slug, :published, :published_at, {categories: :category_id})
    end
end
