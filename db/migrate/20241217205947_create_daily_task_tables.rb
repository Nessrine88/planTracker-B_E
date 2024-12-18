class CreateDailyTaskTables < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_task_tables do |t|
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
