class Admin::DocumentsController < Admin::AdminController
  before_action :require_login
  before_action :set_admin_document, only: [:show, :edit, :update, :destroy]

  # GET /admin/documents
  # GET /admin/documents.json
  def index
    @theme = "default"
    @enable_vue = true
    @admin_documents = Admin::Document.all
  end

  # GET /admin/documents/1
  # GET /admin/documents/1.json
  def show
    @theme = "default"
  end

  # GET /admin/documents/new
  def new
    @enable_vue = true
    @content_types = Admin::ContentType.all 
    @admin_document = Admin::Document.new
  end

  # GET /admin/documents/1/edit
  def edit
    @enable_vue = true 
    @content_types = Admin::ContentType.all 
  end

  # POST /admin/documents
  # POST /admin/documents.json
  def create
    @admin_document = Admin::Document.new(admin_document_params)

    respond_to do |format|
      if @admin_document.save
        format.html { redirect_to @admin_document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @admin_document }
      else
        format.html { render :new }
        format.json { render json: @admin_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/documents/1
  # PATCH/PUT /admin/documents/1.json
  def update
    respond_to do |format|
      if @admin_document.update(admin_document_params)
        # format.html { redirect_to @admin_document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_document }
      else
        format.html { render :edit }
        format.json { render json: @admin_document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/documents/1
  # DELETE /admin/documents/1.json
  def destroy
    @admin_document.destroy
    respond_to do |format|
      format.html { redirect_to admin_documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_document
      @admin_document = Admin::Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_document_params
      params.require(:admin_document).permit(:title, :description, :blurb, content: [ :type, :content ])
    end
end
