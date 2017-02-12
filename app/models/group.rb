class Group < ActiveRecord::Base
  has_many :groups_users
  has_many :users, through: :groups_users

  #vaildates 추가
  validates :name, length: {maximum: 20}, uniqueness: true, presence: true
end
