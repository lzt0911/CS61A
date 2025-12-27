# Lecture 36 Tables
* Two tables A & B are joined by a comma to yield all combos of a row from A & a row from B.
* Two tables may share a column name; dot expressions and aliases disambiguate column values.
```sql
select [columns] from [table1], [table2] where [condition] order by [order];

select * from parents, dogs
    where child = name and fur = "curly";

select a.child as first, b.child as second
    from parents as a, parents as b
    where a.parent = b.parent and a.child < b.child;

create table grandparents as 
    select a.parent as granddog, b.child as grandup
        from parents as a, parents as b
        where a.child = b.parent;
```
* Expressions can contain function calls and arithmetic operators.
```sql
select [columns] from [table] where [expression] order by [expression];
```
* String values can be combined to form longer strings
```sql
sqlite> select "hello," || " world";
hello, world
```
```sql
create table nouns as
    select "dog" as phrase union
    select "cat"           union
    select "bird";

select subject.phrase || " chased " || object.phrase
    from nouns as subject, nouns as object
    where subject.phrase <> object.phrase;
bird chased cat
bird chased dog
cat chased bird
cat chased dog
dog chased bird
dog chased cat
```