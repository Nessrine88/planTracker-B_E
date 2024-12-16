class User < ApplicationRecord
  # Devise modules for authentication
  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  # Association with tasks
  has_many :tasks, dependent: :destroy

end
