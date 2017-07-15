class ProjectsController < ApplicationController
  before_action :find_project, except: [:new, :create, :index]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new

    if @project.update_attributes(project_params)
      flash[:notice] = "Project was saved"
      redirect_to admin_path
    else
      flash.now[:alert] = @project.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update_attributes(project_params)
      flash[:notice] = "Project was updated"
      redirect_to admin_path
    else
      flash.now[:alert] = @project.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    if @project.destroy
      flash[:notice] = "Project was deleted"
      redirect_to admin_path
    else
      flash.now[:alert] = @project.errors.full_messages.to_sentence
      redirect_to admin_path
    end
  end

  def index
    @projects = Project.all
  end

  private

  def find_project
    @project = Project.find(params[:id].to_i)
  end

  def project_params
    params.require(:project).permit(:title, :category, :image)
  end
end
