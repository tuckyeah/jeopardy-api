CREATE TABLE jeopardy (
  id SERIAL PRIMARY KEY,
  show_number INTEGER,
  air_date DATE,
  round TEXT,
  category TEXT,
  value TEXT,
  question TEXT,
  answer TEXT
);
