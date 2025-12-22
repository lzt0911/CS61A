CREATE TABLE pizzas AS
  SELECT "Artichoke" AS name, 12 AS open, 15 AS close UNION
  SELECT "La Val's"         , 11        , 22          UNION
  SELECT "Sliver"           , 11        , 20          UNION
  SELECT "Cheeseboard"      , 16        , 23          UNION
  SELECT "Emilia's"         , 13        , 18;

CREATE TABLE meals AS
  SELECT "breakfast" AS meal, 11 AS time UNION
  SELECT "lunch"            , 13         UNION
  SELECT "dinner"           , 19         UNION
  SELECT "snack"            , 22;

CREATE TABLE opening AS
    SELECT name FROM pizzas WHERE open < 13 ORDER BY name DESC;

CREATE TABLE study AS
    SELECT name, MAX((14-pizzas.open), 0) AS duration FROM pizzas ORDER BY duration DESC;

CREATE TABLE late AS
    SELECT name || " closes at " || pizzas.close AS status FROM pizzas WHERE 
        pizzas.close >= (SELECT time WHERE meals.meal = "snack");

CREATE TABLE double AS
    SELECT a.meal AS first, b.meal AS second, name FROM pizzas, meals AS a, meals AS b
        WHERE b.time - a.time > 6 AND a.time >= pizzas.open AND a.time <= pizzas.close AND  b.time >= pizzas.open AND b.time <= pizzas.close;