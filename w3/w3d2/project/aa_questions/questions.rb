require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
  attr_accessor :fname, :lname
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.all
    users = QuestionsDatabase.instance.execute("SELECT * FROM users")
    users.map { |user| User.new(user) }
  end

  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    raise("User doesn't exist") if user.empty?
    User.new(user.first)
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL
    raise("User doesn't exist") if user.empty?
    User.new(user.first)
  end

  def authored_questions
    questions = Question.find_by_author_id(@id)
    raise("This author has no questions") if questions.empty?
    questions
  end

  def authored_replies
    replies = Reply.find_by_user_id(@id)
    raise("This user has no replies") if replies.empty?
    replies
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def average_karma_ruby
    questions = authored_questions.count
    likes = 0
    authored_questions.each do |question|
      likes += QuestionLike.num_likes_for_question_id(question.id)
    end
    likes.fdiv(questions)
  end

  def average_karma
    karma = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        Cast (COUNT(question_likes.user_id) AS FLOAT) / COUNT (DISTINCT(questions.id))
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON question_likes.question_id = questions.id
      WHERE
        questions.user_id = ?
    SQL
    karma.first.values.first
  end

  def save
    if @id
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
        UPDATE
          users
        SET
          fname = ?, lname = ?
        WHERE
          id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def update
  end

end

class Question

  attr_accessor :title, :body, :user_id
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def self.all
    questions = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    questions.map { |question| Question.new(question) }
  end

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
    raise("Question doesn't exist") if question.empty?
    Question.new(question.first)
  end

  def self.find_by_author_id(author_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL
    raise("Question doesn't exist with that author") if questions.empty?
    questions.map { |question| Question.new(question) }
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    replies = Reply.find_by_question_id(@id)
    replies
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def save
    if @id
      QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @user_id, @id)
        UPDATE
          questions
        SET
          title = ?, body = ?, user_id = ?
        WHERE
          id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @user_id)
        INSERT INTO
          questions (title, body, user_id)
        VALUES
          (?, ?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def update
  end

end

class QuestionFollow

  attr_accessor :user_id, :question_id

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.all
    follows = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
    follows.map { |follow| QuestionFollow.new(follow) }
  end

  def self.find_by_id(id)
    follow = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?
    SQL
    raise("Follow doesn't exist") if follow.empty?
    QuestionFollow.new(follow.first)
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users
      JOIN
        question_follows ON question_follows.user_id = users.id
      WHERE
        question_follows.question_id = ?
    SQL
    raise("There are no followers for this question") if followers.empty?
    followers.map { |follower| User.new(follower) }
  end

  def self.followed_questions_for_user_id(user_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      JOIN
        question_follows ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = ?
    SQL
    raise("There are no followed questions for this user!!") if followers.empty?
    followers.map { |follower| Question.new(follower) }
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        question_follows
      JOIN
        questions ON question_follows.question_id = questions.id
      GROUP BY
        question_follows.question_id
      ORDER BY
        COUNT(question_follows.question_id) DESC
      LIMIT
        ?
    SQL
    questions.map { |question| Question.new(question) }
  end

end

class Reply

  attr_accessor :user_id, :question_id, :body, :parent_reply_id

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @body = options['body']
    @parent_reply_id = options['parent_reply_id']
  end

  def self.all
    replies = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    raise("Reply doesn't exist") if  reply.empty?
    Reply.new(reply.first)
  end

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL
    raise("Reply doesn't exist with that user") if replies.empty?
    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    raise("Reply doesn't exist with that question") if replies.empty?
    replies.map { |reply| Reply.new(reply) }
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_reply_id)
  end

  def child_replies
    children = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = ?
    SQL
    raise("Reply doesn't have children ;_;") if children.empty?
    children.map { |child| Reply.new(child) }
  end

  def save
    if @id
      QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id, @body, @parent_reply_id, @id)
        UPDATE
          replies
        SET
          user_id = ?, question_id = ?, body = ?, parent_reply_id = ?
        WHERE
          id = ?
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id, @body, @parent_reply_id)
        INSERT INTO
          replies (user_id, question_id, body, parent_reply_id)
        VALUES
          (?, ?, ?, ?)
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def update
  end


end

class QuestionLike

  attr_accessor :user_id, :question_id

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.all
    likes = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    likes.map { |like| QuestionLike.new(like) }
  end

  def self.find_by_id(id)
    like = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL
    raise("Like doesn't exist") if like.empty?
    QuestionLike.new(like.first)
  end

  def self.likers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users
      JOIN
        question_likes ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
      GROUP BY
        users.id
    SQL
    users.map { |user| User.new(user) }
  end

  def self.num_likes_for_question_id(question_id)
    likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL
    raise("There are no likes for this unpopular question") if likes.empty?
    likes.first.values.first
  end

  def self.liked_questions_for_user_id(user_id)
    likes = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      JOIN
        question_likes ON question_likes.question_id= questions.id
      WHERE
        question_likes.user_id = ?
    SQL
    likes.map { |like| Question.new(like) }
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      GROUP BY
        question_likes.question_id
      ORDER BY
        COUNT(question_likes.question_id) DESC
      LIMIT
        ?
    SQL
    questions.map { |q| Question.new(q) }
  end
end
