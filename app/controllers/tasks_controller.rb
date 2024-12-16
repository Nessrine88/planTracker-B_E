# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
    # before_action :authenticate_user!  # Ensures the user is authenticated
  
    # POST /tasks
    def create
      # Use current_user to create the task, no need to pass user_id anymore
      @task = current_user.tasks.new(task_params)
  
      if @task.save
        # If the task is successfully created, return the task with a success message
        render json: { message: 'Task created successfully', task: @task }, status: :created
      else
        # If there are validation errors, return the errors with a 422 status
        render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    # Strong parameters for task creation
    def task_params
      params.require(:task).permit(:title, :description, :start_date, :end_date)
    end
  end
  