class Task < ApplicationRecord
  belongs_to :user
  has_many :daily_task_tables, dependent: :destroy
end
