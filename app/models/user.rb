class User < ActiveRecord::Base
  has_many :groups_users
  has_many :groups, through: :groups_users
  has_many :posts

  #이메일 형식 정규표현식
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  #이름 첫글자 대문자화
  before_save{self.name.capitalize!}
  #vaildates 하기
  validates :name, length: {maximum: 10}, presence: true
  validates :age, numericality: {only_integer: true, greater_than: 19, less_than:30}, presence: true
  validates :mail, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}, presence: true
end
