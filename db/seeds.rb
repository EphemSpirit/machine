require 'open-uri'

#Example users
50.times do |n|
  name = Faker::Name.first_name
  email = Faker::Internet.safe_email
  username = "itsuser#{n+1}"
    user = User.create!(name: name,
                        email: email,
                        username: username,
                        password: 'password',
                        password_confirmation: 'password')
end

@users = User.all

@users.each do |user|
  image = open(Faker::Fillmurray.image)
  user.profile.profile_pic.attach(io: image, filename: "profilepic.jpg")
  user.profile.bio = Faker::Lorem.sentence(word_count: 5)
  user.profile.birthday = Faker::Date.birthday(min_age: 18, max_age: 50)
  user.profile.save
end

#build some friendships
20.times do
  @users = User.all
  buddy = @users.sample

  buddy.friendships.create!(friender: buddy, friendee: @users.sample)

end

#build some inverse friendships
20.times do
  @user = User.all
  friend = @users.sample
  friend.inverse_friends.create!(friender: @users.sample, friendee: friend)

end

#build posts
100.times do
  @users = User.all
  @user = @users.sample
  @user.posts.create!(author: @user, body: Faker::Lorem.paragraph(sentence_count: 4))
end
