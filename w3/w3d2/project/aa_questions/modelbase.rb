require_relative 'questions.rb'

class ModelBase

  attr_reader = :type

  def initialize(type)
    @type = nil
  end

  def self.find_by_id
    object = QuestionsDatabase.instance.execute(<<-SQL, @type, id)
      SELECT
        *
      FROM
        ?
      WHERE
        id = ?
    SQL
    raise("User doesn't exist") if object.empty?
    create_object(@type, object.first)
  end

  def self.create_object(type, data)
    eval(type + '.new(data)')
  end
end
