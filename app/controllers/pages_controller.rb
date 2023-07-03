class PagesController < ApplicationController
  before_action :set_project
  before_action :set_page, only: %i[ show update destroy ]
  helper_method :new

  include PagesHelper

  # def index
  #   if (@page = @project.pages.top_level.first)
  #   else
  #     @page = @project.pages.create!
  #   end
  #   redirect_to @page
  # end
  #
  # def show
  # end

  # GET /pages/new
  def new
    @page = @project.pages.build
  end

  # POST /pages or /pages.json
  def create
    @page = @project.pages.build(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to project_page_path(@project, @page), notice: "Page was successfully created." }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1 or /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to project_page_path(@project, @page), notice: "Page was successfully updated." }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1 or /pages/1.json
  def destroy
    @page.destroy

    respond_to do |format|
      # TODO: Redirect to project
      format.html { redirect_to root_path, notice: "Page was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_page
      @page = Page.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:title, :content, :parent_id, :position)
    end
end
