''''
  # Learning_PotgreSQL

  # To create a User:
  '''
  CREATE USER <name_of_user>
  DROP USER <name_of_user>
  '''

  # To create a DataBase:
  CREATE DATABASE <name_of_database>
  DROP DATABASE <name_of_database>

  # To create a Table:
  CREATE TABLE <name_of_table>
  DROP TABLE <name_of_table>

  Reveal items of Table:
  SELECT * FROM <name_of_table> 

  # Sorting:
  SELECT * FROM <name_of_table> ORDER BY <selected_collumn> (, you can add more) ASC / DESC 
  example: 
  SELECT * FROM person ORDER BY id DESC (it sorts in descending order)

  Or sort by DISTICT items:
  SELECT DISTINCT <selected_collumn> FROM <name_of_table> ORDER BY <selected_collumn> (, you can add more) ASC / DESC;
  example;
  SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth DESC;

  # WHERE clause, AND, OR;
  SELECT * FROM <name_of_table> WHERE <name_of_column> = “exact value of the data” AND  (<name_of_column> = “exact value of the data” OR <name_of_column> = “exact value of the data”);
  example:
  SELECT * FROM person WHERE country_of_birth = ‘Russia’ AND (gender = ‘Male’ OR gender = ‘Female’);

  # Comparison:
  SELECT 1 <> 2             -        1 is not equal to 2
  SELECT 1 > 2   (1<2)            -        1 is greater than 2 ( 2 is greater than 1)
  SELECT 1 <= 2 (1>=2)          -        2 is greater or equal to 2 (1 is greater or equal to 2)

  # OFFSET, LIMIT or FETCH:
  SELECT * FROM person LIMIT 10;
  SELECT * FROM person OFFSET 5 LIMIT 3;
  SELECT * FROM person OFFSET 5 FETCH 3 ROW ONLY;

  # BETWEEN:
  SELECT * FROM person WHERE date_of_birth BETWEEN (‘DATE’ optional ) ‘2014-02-15’ AND ‘2021-07-25’;
''''






