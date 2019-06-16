require 'test_helper'

class InterviewTest < ActiveSupport::TestCase

  def setup
    create_answers_and_ratings
  end

  test "interviews have multiple questions" do
    i = interviews(:first_driver_interview)
    assert i.interview_questions.any?
  end

  test "interview questions should have answers" do
    i = interviews(:first_driver_interview)
    assert i.questions.first.answers.any?
  end

  # fixed test case to order interview questions
  test "interview questions should be in order" do
    i = interviews(:first_driver_interview)
    assert_equal i.interview_questions.where(display_order: 1).first.display_order, 1
  end

  # test case to calculate average rating
  test "candidate avarage rating" do
    i = Candidate.first.average_rating
    assert_equal i, 1
  end

  # test case to fetch upcoming interview, candidate details and questions
  test "interviewer upcoming interviews" do
    i = Candidate.first.info_and_interview_details
    assert_equal i[:interview_schedules], ["Interviewing Barney Rubble for the truck driver position", "Interviewing Barney Rubble for the truck driver position for second time"]
  end
end
