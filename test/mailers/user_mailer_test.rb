require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "thank_you" do
    user = User.first
    mail = UserMailer.thank_you(user)
    assert_equal "Thank you", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match user.name, mail.body.encoded
  end

end
