class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  #욕설 배열화
  bad_mouth=%w(shit fuck hell)
  #욕설 필터링 작업
  before_save{ bad_mouth.each {|b| self.content.gsub!(/#{b}/, '****') if self.content.include? b}}
  #vaildates 추가
  validates :title, length: {minimum: 2 , maximum: 30}, presence: true
  validates :content, presence: true
end
