class PagesController < ApplicationController
  before_action :set_project
  before_action :set_page, only: %i[ show edit update destroy ]

  helper_method :new

  include PagesHelper

  def new
    @page = @project.pages.build
    authorize @page
  end

  def show
    authorize @page
  end

  def edit
    authorize @page
  end

  def create
    @page = @project.pages.build(page_params)
    authorize @page

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

  def update
    authorize @page
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

  def search
    if params[:search].present?
      @pages = @project.pages.search_by_title(params[:search])
    else
      @pages = []
    end
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "suggestions",
          partial: "shared/search_results",
          locals: { pages: @pages}
        )
      end
    end
  end

  def destroy
    @page.destroy

    respond_to do |format|
      # TODO: Redirect to project
      format.html { redirect_to root_path, notice: "Page was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_page
      @page = Page.find_by(slug: params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def page_params
      params.require(:page).permit(:title, :content, :parent_id, :position)
    end
end
