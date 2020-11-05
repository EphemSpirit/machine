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

@users = User.all

@users.each do |user|
  user.profile.profile_pic = Faker::Fillmurray.image
  user.profile.bio = Faker::TvShows::AquaTeenHungerForce.quote
  user.profile.birthday = Faker::Date.birthday(min_age: 18, max_age: 50)
end
