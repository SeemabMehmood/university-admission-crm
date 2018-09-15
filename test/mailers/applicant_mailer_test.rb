require 'test_helper'

class ApplicantMailerTest < ActionMailer::TestCase
  test "forward" do
    mail = ApplicantMailer.forward
    assert_equal "Forward", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
