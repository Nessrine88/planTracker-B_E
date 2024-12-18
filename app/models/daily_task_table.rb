class DailyTaskTable < ApplicationRecord
  belongs_to :user
  belongs_to :task
   # Set the default value for status to false
   after_initialize :set_default_status, if: :new_record?

   def set_default_status
     self.status ||= false  # Default to false if not set
   end
   validates :status, inclusion: { in: [true, false] }
   validates :date, presence: true
   validates :user, presence: true
  validates :task, presence: true
end
