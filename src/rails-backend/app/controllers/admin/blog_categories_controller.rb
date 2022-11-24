class Admin::BlogCategoriesController < Admin::AdminController
  before_action :require_login
  before_action :set_admin_blog_category, only: [:show, :edit, :update, :destroy]

  # GET /admin/blog_categories
  # GET /admin/blog_categories.json
  def index
    @admin_blog_categories = Admin::BlogCategory.all
  end

  # GET /admin/blog_categories/1
  # GET /admin/blog_categories/1.json
  def show
  end

  # GET /admin/blog_categories/new
  def new
    @admin_blog_category = Admin::BlogCategory.new
  end

  # GET /admin/blog_categories/1/edit
  def edit
  end

  # POST /admin/blog_categories
  # POST /admin/blog_categories.json
  def create
    @admin_blog_category = Admin::BlogCategory.new(admin_blog_category_params)

    respond_to do |format|
      if @admin_blog_category.save
        format.html { redirect_to @admin_blog_category, notice: 'Blog category was successfully created.' }
        format.json { render :show, status: :created, location: @admin_blog_category }
      else
        format.html { render :new }
        format.json { render json: @admin_blog_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/blog_categories/1
  # PATCH/PUT /admin/blog_categories/1.json
  def update
    respond_to do |format|
      if @admin_blog_category.update(admin_blog_category_params)
        format.html { redirect_to @admin_blog_category, notice: 'Blog category was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_blog_category }
      else
        format.html { render :edit }
        format.json { render json: @admin_blog_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/blog_categories/1
  # DELETE /admin/blog_categories/1.json
  def destroy
    @admin_blog_category.destroy
    respond_to do |format|
      format.html { redirect_to admin_blog_categories_url, notice: 'Blog category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_blog_category
      @admin_blog_category = Admin::BlogCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_blog_category_params
      params.require(:admin_blog_category).permit(:title, :description)
    end
end
