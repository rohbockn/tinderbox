# Overview of common tasks and forms used in sql (by me - super basic)

## Changing a password

```alter user <your_user_name> identified by <new_password> REPLACE <old_password>```

## Most basic search:

### What I'm used to
Just remember:  select, from, where

```
select field1 field2 etc
from this_table table_nickname,
  that_table t2,
  full_table_name
where full_table_name.key1=t2.key1
  AND t2.key2=table_nickname.key2
  AND field1 < 5
```
### What I should learn (ANSI):

In the above example query the first two where statements are joins (inner joins).  This (using the '=' for joins) is considered an old style of writing queries.  The newer standard (not that new) is the ANSI standard and has three varieties:

- join (an inner join)
- left join
- right join
- full join

whichever you use, the syntax is the same pattern:

```
select <c.s. column names>
from <table>
left join <table2> on <table.key>=<table2.key>;
```
Two interesting things here; one being that all the needed tables are not listed in the from clause, second is that I believe you can insert a where clause before the join.  What I don't know is if you can only use the tables in the from statement or not for the where clauses.  My gut says not.
