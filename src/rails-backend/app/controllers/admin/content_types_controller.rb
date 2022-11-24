class Admin::ContentTypesController < Admin::AdminController
  before_action :require_login
  before_action :set_admin_content_type, only: [:show, :edit, :update, :destroy]

  # GET /admin/content_types
  # GET /admin/content_types.json
  def index
    @admin_content_types = Admin::ContentType.all
  end

  # GET /admin/content_types/1
  # GET /admin/content_types/1.json
  def show
  end

  # GET /admin/content_types/new
  def new
    @admin_content_type = Admin::ContentType.new
  end

  # GET /admin/content_types/1/edit
  def edit
  end

  # POST /admin/content_types
  # POST /admin/content_types.json
  def create
    @admin_content_type = Admin::ContentType.new(admin_content_type_params)

    respond_to do |format|
      if @admin_content_type.save
        format.html { redirect_to @admin_content_type, notice: 'Content type was successfully created.' }
        format.json { render :show, status: :created, location: @admin_content_type }
      else
        format.html { render :new }
        format.json { render json: @admin_content_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/content_types/1
  # PATCH/PUT /admin/content_types/1.json
  def update
    respond_to do |format|
      if @admin_content_type.update(admin_content_type_params)
        format.html { redirect_to @admin_content_type, notice: 'Content type was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_content_type }
      else
        format.html { render :edit }
        format.json { render json: @admin_content_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/content_types/1
  # DELETE /admin/content_types/1.json
  def destroy
    @admin_content_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_content_types_url, notice: 'Content type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_content_type
      @admin_content_type = Admin::ContentType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_content_type_params
      params.require(:admin_content_type).permit(:name, :ordering)
    end
end
