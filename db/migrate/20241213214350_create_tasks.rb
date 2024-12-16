class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.date :startDate
      t.date :endDate
      t.references :user, null: false, foreign_key: true
      t.decimal :acheivement

      t.timestamps
    end
  end
end
