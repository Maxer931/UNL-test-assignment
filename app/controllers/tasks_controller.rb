class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, only: [:create, :index, :new]



  def new
    @task = @project.tasks.build
    @checked_user = User.where('task_id' => 0).first    #variable contains the user who will be checked by default when creating a job
  end


  def create
    @task = @project.tasks.build(task_params)  #creation of a new task that belongs to a certain project
    if @task.save
      redirect_to tasks_path(@project)                  #redirection to views/tasks/index.html.erb
    end
  end

  def edit
    @task = Task.find(params[:id])
    @user = User.where(task_id: @task ) + User.where(task_id: 0 )   #creation of an array of users who have no task to perform
  end                                                             # and user who performs this task


  def index
    @task = Task.where(project_id: @project )         #search of tasks and users who perform these tasks
    @user = User.where(task_id: @task )
  end


  def show
    @project = Project.find(params[:id])       #search of tasks and users who perform these tasks
    @task = Task.where(project_id: @project )
    @user = User.where(task_id: @task )
    $project_id = params[:id]
  end


  def update
    @task = Task.find(params[:id])
    @user = User.where(task_id: @task )
    @user.update(task_id: 0)
    if @task.update(task_params)                      #uptade of task and user
      @user = User.where(task_id: @task.user_id )     #task_id is the argument of the user who stores the _id of the task performed by the user
      @user.update(task_id: @task.id)
      redirect_to tasks_path
    else
      render :edit
    end
  end


  def destroy                                          #destruction of task
    @task = Task.find(params[:id])
    @user = User.where(task_id: @task )
    if @task.destroy and @user.update(task_id: 0)      #by assigning 0 to the value task_id we remove user from task
      redirect_to tasks_path
    else
      redirect_to tasks_path, error: 'Unable to delete project'
    end
  end


  def find_project
    @project=Project.find($project_id)                #this function finds project
  end




  def task_params
    params[:task].permit(:title, :description, :status, :project_id, :user_ids)
  end

  $status=['New', 'In progress', 'Done']                    #this variable contains values of task's status

end
