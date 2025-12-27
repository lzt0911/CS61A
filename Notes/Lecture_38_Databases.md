# Lecture 38 Databases
## Create, Drop, Insert, Update, Delete
* Create table
```sql
CREATE TABLE numbers (n, note);
CREATE TABLE numbers (n, UNIQUE, note);
CREATE TABLE numbers (n, note DEFAULT "No comment");
```
* Drop table
```sql
DROP TABLE numbers;
DROP TABLE IF EXISTS numbers;
```
* Insert
```sql
INSERT INTO t(column) VALUES (value);
INSERT INTO t VALUES (value0, value1);
```
```sql
sqlite> create table primes(n UNIQUE, prime DEFAULT 1);
sqlite> INSERT INTO primes VALUES (2, 1), (3, 1);
sqlite> select * from primes;
2 | 1
3 | 1
sqlite> INSERT INTO primes(n) VALUES (4), (5), (6), (7);
sqlite> select * from primes;
2 | 1
3 | 1
4 | 1
5 | 1
6 | 1
7 | 1
sqlite> INSERT INTO primes(n) SELECT n + 6 FROM primes;
sqlite> select * from primes;
2 | 1
3 | 1
4 | 1
5 | 1
6 | 1
7 | 1
8 | 1
9 | 1
10 | 1
11 | 1
12 | 1
13 | 1
```
* Update
```sql
sqlite> UPDATE primes SET prime=0 WHERE n > 2 AND n % 2 = 0;
sqlite> select * from primes;
2 | 1
3 | 1
4 | 0
5 | 1
6 | 0
7 | 1
8 | 0
9 | 1
10 | 0
11 | 1
12 | 0
13 | 1
```
* Delete
```sql
sqlite> DELETE FROM primes WHERE prime=0;
sqlite> select * from primes;
2 | 1
3 | 1
5 | 1
7 | 1
9 | 1
11 | 1
13 | 1
```
## Python and SQL
```python
import sqlite3

db = sqlite3.Connection("n.db")
db.execute("CREATE TABLE nums AS SELECT 2 UNION SELECT 3;")
db.execute("INSERT INTO nums VALUES (?), (?), (?);".range(4, 7))
print(db.execute("SELECT * FROM nums;").fetchall()) # [(2,), (3,), (4,), (5,), (6,)]
db.commit()
```