CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR NOT NULL,
  lname VARCHAR NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR,
  body TEXT,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  body TEXT,
  parent_reply_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

--seeding the database

INSERT INTO
  users (fname, lname)
VALUES
  ('Jin', 'Chen'),
  ('Halle', 'Berry'),
  ('Leland', 'Krych'),
  ('Allison', 'Bree');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('What is life?', 'Life is a box of chocolates', 1),
  ('How to grow your 401k in 1 week?', 'Diversify, Diversify, Diversify', 3),
  ('When am I going to be in a movie again?', 'Never', 2),
  ('What should we do this weekend?', 'Go snorkeling', 4),
  ('What is love?', 'Love is fake', 1);

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  (1,4),
  (2,3),
  (3,4),
  (4,1),
  (1,3);

INSERT INTO
  replies (question_id, user_id, body, parent_reply_id)
VALUES
  (1, 3, 'Hey, isn''t that what Forrest Gump said?', NULL),
  (1,1, 'Yeah, lol.',1),
  (2,3, 'Hey, I''ve spent all my movie $, what does diversify mean?', NULL),
  (3,3, 'That''s disappointing.', NULL),
  (4,1, 'Where are you going snorkeling?', NULL),
  (4,4, 'We''re going to Hawaii!',5);


INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (1,4),
  (2,3),
  (3,4),
  (4,1),
  (4,2),
  (4,3),
  (4,4),
  (3,2);

-- SELECT
--   *
-- FROM
--   replies
-- JOIN
--   questions ON questions.id = replies.question_id
-- WHERE
--   replies.question_id = 1
