class Question < ApplicationRecord
  validates :question_text, :poll_id, presence: true

  def n_plus_1_results
    count = {}
    answer_choices.each do |answer_choice|
      count[answer_choice.answer_text] = answer_choice.responses.length
    end
    count
  end

  def kinda_good_results
    count = {}
    answers = answer_choices.includes(:responses)
    answers.each do |answer_choice|
      count[answer_choice.answer_text] = answer_choice.responses.length
    end
    count
  end

  def results
    Question.find_by_sql([<<-SQL, self.id])
      SELECT
        answer_choices.answer_text, COUNT(responses.id)
      FROM
        answer_choices
      LEFT OUTER JOIN
        responses ON responses.answer_choice_id = answer_choices.id
      WHERE
        answer_choices.question_id = ?
      GROUP BY
        answer_choices.answer_text
    SQL
  end

  has_many :responses,
    through: :answer_choices,
    source: :responses

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: "AnswerChoice"

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: "Poll"
end
