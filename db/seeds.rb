#Example users
50.times do |n|
  name = Faker::Name.first_name
  email = Faker::Internet.safe_email
  username = "itsuser#{n+1}"
  User.create!(name: name,
               email: email,
               username: username,
               password: 'password',
               password_confirmation: 'password')
end
