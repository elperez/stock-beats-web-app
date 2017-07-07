CREATE TABLE stock(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(20),
  code VARCHAR(5),
  api VARCHAR(50)
);

CREATE TABLE users(
  id SERIAL4 PRIMARY KEY,
  first_name VARCHAR(20),
  last_name VARCHAR(20),
  email VARCHAR(400),
  stock_favorites text[],
  password_digest TEXT
);

INSERT INTO dishes(first_name, last_name, email, stock_favorites,password_digest)
VALUES ("Kit", "Perez", "kit.perez@gmail.com", ["MSFT", "AAPL"], "helloworld");
.em
