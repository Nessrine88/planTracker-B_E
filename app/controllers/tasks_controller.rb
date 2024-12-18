class TasksController < ApplicationController
  # before_action :authenticate_user!  # Ensures the user is authenticated
def index
  user = User.find_by(id: params[:user_id])

    if user
      @tasks = user.tasks  # Assuming Task has a relationship with User (i.e., a user has many tasks)
      render json: @tasks
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end
  def create
    # Create task directly for the authenticated user
    @task = Task.new(task_params)

    if @task.save
      render json: { message: 'Task created successfully', task: @task }, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find_by(id:params[:id])
    if @task
      @task.destroy
      render json: {error: 'Task successfully deleted'}, status: :ok
    else
      render json: {error: 'Task not found or not authorized to delete this task'}, status: :not_found
    end
  end



  private

  # Strong parameters
  def task_params
    params.require(:task).permit(:title, :description, :startDate, :endDate, :user_id)
  end
end
