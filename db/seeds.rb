10.times do |n|
  Label.create(name: "test#{n + 1}")
end

10.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "#{n}1"
  admin_flag = true
  User.create!(name: name,
              email: email,
              password: password,
              admin_flag: admin_flag
              )
end

10.times do |n|
  title = Faker::Games::Zelda.game
  content = Faker::Games::Zelda.location
  Task.create!(title: title,
                  content: content,
                  deadline: "2022/04/10",
                  status: "未着手",
                  priority: "低",
                  user_id: n + 1
                  )
end
