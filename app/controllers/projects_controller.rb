class ProjectsController < ApplicationController
  before_action :set_project

  def index
    @projects = Project.all
    # authorize @projects
  end

  def show
    # authorize @project
    if (@page = @project.pages.top_level.first)
      redirect_to project_page_path(@project, @page)
    else
      @page = @project.pages.create(title: "First page in #{@project.title}")
      # authorize @page
      redirect_to edit_project_page_path(@project, @page)
    end
  end

  def new
    @project = Project.new
    # authorize @project
  end

  def create
    @project = Project.new(project_params)
    # authorize @project
    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
        # create first page automatically
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # TODO: dependent: destroy
    # authorize @project
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find_by(slug: params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :description)
    end
end
