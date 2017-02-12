#멋사 심화 5주차 과제

##vaildates 추가하기

### user.rb
```ruby
#이메일 형식 정규표현식
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
#이름 첫글자 대문자화
before_save{self.name.capitalize!}
#vaildates 하기
validates :name, length: {maximum: 10}, presence: true
validates :age, numericality: {only_integer: true, greater_than: 19, less_than:30}, presence: true
validates :mail, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}, presence: true
```

### post.rb
```ruby
#욕설 배열화
bad_mouth=%w(shit fuck hell)
#욕설 필터링 작업
before_save{ bad_mouth.each {|b| self.content.gsub!(/#{b}/, '****') if self.content.include? b}}
#vaildates 추가
validates :title, length: {minimum: 2 , maximum: 30}, presence: true
validates :content, presence: true
```

### comment.rb
```ruby
#욕설 배열화
bad_mouth=%w(shit fuck hell)
#욕설 필터링
before_save{ bad_mouth.each {|b| self.content.gsub!(/#{b}/, '****') if self.content.include? b}}
#vaildates 추가
validates :content, length: {maximum: 200}, presence: true
```

### group.rb
```ruby
#vaildates 추가
validates :name, length: {maximum: 20}, uniqueness: true, presence: true
```

### seeds.rb
확인용 seeds 파일
```ruby
5.times do
	User.create(name: Faker::Name.first_name, mail: Faker::Internet.free_email,age: rand(19)+20)
end

5.times do
	User.create(name: Faker::Name.first_name, mail: Faker::Internet.free_email,age: rand(19)+40)
end

#욕설 필터링 검증용
Post.create([{user_id: 5, title: Faker::Lorem.word, content: "fuck boy goto hell!!"}])

Group.create name: :young
Group.create name: :old

User.all.each do |a|
    if a.age<40
       GroupsUser.create(user_id: a.id, group_id: 1)
    else
       GroupsUser.create(user_id: a.id, group_id: 2)
    end
end

Group.find(1).users.each do |u|
	Like.create(user_id: u.id, post_id: 1)
	#욕설 필터링 검증용
	Comment.create(user_id: u.id, post_id: 1, content: "fuck you")
end

Group.find(2).users.each do |u|
	Comment.create(user_id: u.id, post_id: 1, content: "fuck you")
end

```
