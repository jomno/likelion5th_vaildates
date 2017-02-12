# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do
	User.create(name: Faker::Name.first_name, mail: Faker::Internet.free_email,age: rand(19)+20)
end

5.times do
	User.create(name: Faker::Name.first_name, mail: Faker::Internet.free_email,age: rand(19)+40)
end

#욕설 필터링 검증용
Post.create([{user_id: 1, title: Faker::Lorem.word, content: "fuck boy goto hell!!"}])

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
