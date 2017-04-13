class Response < ApplicationRecord
  validates :user_id, :answer_choice_id, presence: true
  validate :cannot_respond_twice, :cannot_respond_to_own_poll


  has_one :question,
    through: :answer_choice,
    source: :question

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: "AnswerChoice"

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.user_id)
  end

  private

  def cannot_respond_twice
    if respondent_already_answered?
      errors[:base] << "User already responded"
    end
  end

  def cannot_respond_to_own_poll
    author = answer_choice.question.poll.author_id
    if self.user_id = author
      errors[:base] << "Cannot respond to own poll!"
    end
  end
end
