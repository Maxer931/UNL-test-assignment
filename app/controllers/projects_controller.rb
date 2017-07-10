class ProjectsController < ApplicationController

  before_action :find_project, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_user!

  def new
    @project = Project.new
  end

  def create
   @project = Project.new(project_params)        #creating new project
    if @project.save
      redirect_to projects_path                  #redirecting to views/projects/index.html.erb
    else
      render :new
    end
  end

  def index
    @projects= Project.all                        #displaying all projects
  end

  def edit
  end

  def update                                      #updating project
    if @project.update(project_params)
      redirect_to projects_path
    else
      render :edit
    end
  end

  def destroy                                      #deleting project
    @project = Project.find(params[:id])      #search of tasks and users who perform these tasks
    @task = Task.where(project_id: @project )
    @user = User.where(task_id: @task )
      if @project.destroy and  @task.delete_all and @user.update(task_id: 0)
        redirect_to projects_path                  #redirecting to views/projects/index.html.erb
      else
        redirect_to projects_path, error: 'Unable to delete project'
      end
  end

  def find_project
    @project=Project.find(params[:id])         #this function finds project
  end

  def project_params
    params[:project].permit(:name, :summary, :start_date, :end_date)
  end


end
