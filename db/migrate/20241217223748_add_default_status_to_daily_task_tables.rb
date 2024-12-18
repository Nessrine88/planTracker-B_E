class AddDefaultStatusToDailyTaskTables < ActiveRecord::Migration[8.0]
  def change
    change_column_default :daily_task_tables, :status, false
  end
end
