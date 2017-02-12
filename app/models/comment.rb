class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  #욕설 배열화
  bad_mouth=%w(shit fuck hell)
  #욕설 필터링
  before_save{ bad_mouth.each {|b| self.content.gsub!(/#{b}/, '****') if self.content.include? b}}
  #vaildates 추가
  validates :content, length: {maximum: 200}, presence: true
end
