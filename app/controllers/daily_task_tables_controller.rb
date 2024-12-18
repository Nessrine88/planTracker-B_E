class DailyTaskTablesController < ApplicationController
  before_action :set_daily_task_table, only: [:update]

  # POST /users/:user_id/tasks/:task_id/daily_task_tables
  def create
    @user = User.find_by(id: params[:user_id])
    if @user.nil?
      Rails.logger.error("User with ID #{params[:user_id]} not found")
      render json: { error: "User not found" }, status: :not_found
      return
    end

    @task = @user.tasks.find_by(id: params[:task_id])
    if @task.nil?
      Rails.logger.error("Task with ID #{params[:task_id]} not found for user #{params[:user_id]}")
      render json: { error: "Task not found" }, status: :not_found
      return
    end

    # Check if a daily task table entry already exists for this user, task, and date
    @daily_task_table = @task.daily_task_tables.find_by(user_id: @user.id, date: params[:daily_task][:date])

    if @daily_task_table
      # If it exists, update the status (toggle between true and false)
      if @daily_task_table.update(status: !@daily_task_table.status)
        render json: @daily_task_table, status: :ok
      else
        Rails.logger.error("Failed to update daily task: #{@daily_task_table.errors.full_messages}")
        render json: @daily_task_table.errors, status: :unprocessable_entity
      end
    else
      # If it doesn't exist, create a new entry
      @daily_task_table = @task.daily_task_tables.new(daily_task_params.merge(user_id: @user.id))

      if @daily_task_table.save
        render json: @daily_task_table, status: :created
      else
        Rails.logger.error("Failed to create daily task: #{@daily_task_table.errors.full_messages}")
        render json: @daily_task_table.errors, status: :unprocessable_entity
      end
    end
  end

  # GET /users/:user_id/tasks/:task_id/daily_task_tables
  def index
    @user = User.find_by(id: params[:user_id])
    if @user.nil?
      render json: { error: "User not found" }, status: :not_found
      return
    end

    @task = @user.tasks.find_by(id: params[:task_id])
    if @task.nil?
      render json: { error: "Task not found" }, status: :not_found
      return
    end

    @daily_task_tables = @task.daily_task_tables
    render json: @daily_task_tables, status: :ok
  end

  # PUT /users/:user_id/tasks/:task_id/daily_task_tables/:id
  def update
    if @daily_task_table.update(daily_task_params)
      render json: @daily_task_table, status: :ok
    else
      render json: @daily_task_table.errors, status: :unprocessable_entity
    end
  end

  private

  # Method for setting the daily task table (used in the update action)
  def set_daily_task_table
    @task = Task.find_by(id: params[:task_id])
    if @task.nil?
      render json: { error: "Task not found" }, status: :not_found
      return
    end
    @daily_task_table = @task.daily_task_tables.find_by(id: params[:id])
    if @daily_task_table.nil?
      render json: { error: "DailyTaskTable not found" }, status: :not_found
    end
  end

  # Strong parameters for daily_task
  def daily_task_params
    params.require(:daily_task).permit(:status, :date)
  end
end
