DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
  id INTEGER PRIMARY KEY,
  dept_id INTEGER NOT NULL,
  boss_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  salary INTEGER NOT NULL
);

DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

INSERT INTO
  employees(dept_id, boss_id, name, salary)
VALUES
  (1, 1, 'Jin', 1000000),
  (1, 1, 'Foo', 500000),
  (1, 1, 'Baz', 500000),
  (1, 3, 'Bar', 20000),
  (1, 3, 'Bax', 20000),
  (2, 2, 'Boo', 20000),
  (2, 2, 'Poo', 20000);

INSERT INTO
  departments(name)
VALUES
  ('Operations'),
  ('HR');
