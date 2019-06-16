class Candidate < ApplicationRecord
  has_many :interviews
  has_many :positions, through: :interviews
  has_many :questions, through: :interviews
  has_many :answers

  # to calculate average_rating
  def average_rating
    self.class.joins(:answers => :answer_ratings).where("answer_ratings.rating != 0").where("candidates.id = ?", id).average("answer_ratings.rating").to_f
  end

  # returns hash for next two interviews, candidate details and questions
  def info_and_interview_details
    details = {}
    details[:interview_schedules] = interviews.select{|interview| interview.interview_date > Date.current}.sort_by(&:interview_date).first(2).pluck(:description)
    details[:info] = [name, email]
    details[:questions] = questions.pluck(:question)
    details
  end
end
