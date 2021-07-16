# Learning_PotgreSQL 

## To create a User:
>CREATE USER <name_of_user>;
>
>DROP USER <name_of_user>;


## To create a DataBase:
>CREATE DATABASE <name_of_database> ;
>
>DROP DATABASE <name_of_database> ;

## To create a Table:
>CREATE TABLE <name_of_table> ;
>
>DROP TABLE <name_of_table>;

#### Reveal items of Table:
>SELECT * FROM <name_of_table> ;

## Sorting:
>SELECT * FROM <name_of_table> ORDER BY <selected_collumn> (, you can add more) ASC / DESC ;

example: 
>SELECT * FROM person ORDER BY id DESC (it sorts in descending order);

#### Or sort by DISTICT items:
>SELECT DISTINCT <selected_collumn> FROM <name_of_table> ORDER BY <selected_collumn> (, you can add more) ASC / DESC ;

example
>SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth DESC;

## WHERE clause, AND, OR;
>SELECT * FROM <name_of_table> WHERE <name_of_column> = “exact value of the data” AND  (<name_of_column> = “exact value of the data” OR <name_of_column> = “exact value of the data”);

example
>SELECT * FROM person WHERE country_of_birth = ‘Russia’ AND (gender = ‘Male’ OR gender = ‘Female’);

## Comparison:
>SELECT 1 <> 2             -        1 is not equal to 2
>
>SELECT 1 > 2   (1<2)            -        1 is greater than 2 ( 2 is greater than 1)
>
>SELECT 1 <= 2 (1>=2)          -        2 is greater or equal to 2 (1 is greater or equal to 2)

## OFFSET, LIMIT or FETCH:
>SELECT * FROM <name_of_table> LIMIT 10;
>
>SELECT * FROM <name_of_table> OFFSET 5 LIMIT 3;
>
>SELECT * FROM <name_of_table> OFFSET 5 FETCH 3 ROW ONLY;

## BETWEEN:
>SELECT * FROM <name_of_table> WHERE <name_of_column> BETWEEN (‘DATE’ optional ) ‘2014-02-15’ AND ‘2021-07-25’;

## LIKE, ILIKE:
>SELECT * FROM <name_of_table> WHERE <name_of_column> LIKE <search from_the_existing_data>;
>
>SELECT * FROM <name_of_table> WHERE <name_of_column> ILIKE <search from_the_existing_data>;  
  
(The difference between LIKE and ILIKE is that ILIKE also accepts related values. For example: "p%" will search for all lower p and upper P).
  
## GROUP BY, HAVING:
>SELECT <name_of_column>, <name_of_column> FROM <name_of_table> GROUP BY <name_of_column>;
>
>SELECT <name_of_column>, COUNT(*) FROM <name_of_table> GROUP BY <name_of_column> HAVING COUNT(*) > 5;
  
example:
>SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth;
>
>SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth HAVING COUNT(*) > 5;
  
## SUM, MIN, MAX, AVG:
>SELECT MIN(<name_of_column>) FROM <name_of_table>;
>
>SELECT MAX(<name_of_column>) FROM <name_of_table>;
>
>SELECT AVG(<name_of_column>) FROM <name_of_table>;
> 
>SELECT <name_of_column>, SUM(<name_of_column>) FROM <name_of_table> GROUP BY <name_of_column>;

## Arithmetic Operations:
>SELECT <name_of_column>, <name_of_column>, <name_of_column> * 0.10 FROM <name_of_table> GROUP BY <name_of_column>, <name_of_column>;     # it calculates 10% of the price
  
example:
>SELECT make, price, price * .10 FROM car GROUP BY make, price;
  
## Aliases:
>SELECT <name_of_column> AS <name_of_alias> FROM <name_of_table>;

example:
>SELECT price AS original_price FROM car;
  
## COALESCE:
>SELECT COALESCE(<name_of_column>, 'Write Anything You Want') FROM <name_of_table>;
  
example:
>SELECT COALESCE(email, 'Email was not provided') FROM person;
  
## NULLIF:
>SELECT NULLIF(2, 2);   # It will return Null
>
>SELECT 10 / NULLIF(2,2)   # This will not throw an exception as it would do with 10 / 0

example:
>SELECT COALESCE(10 / NULLIFF(2,2), 6);
  
## Date
>SELECT NOW();
>
>SELECT NOW()::DATE;
>
>SELECT NOW()::TIME;

#### Adding and Substracting Dates with INTERVAL:
>SELECT NOW() - INTERVAL '5 YEARS';
>
>SELECT NOW() - INTERVAL '2 MONTHS';
>
SELECT NOW() - INTERVAL '10 DAYS';
  
#### EXTRACT data of DATE:
>SELECT EXTRACT(YEAR FROM NOW());
>
>SELECT EXTRACT(MONTH FROM NOW());
>
>SELECT EXTRACT(DAY FROM NOW());
  
#### AGE function;
>SELECT <DATE_collumn>, AGE(NOW(), <DATE_collumn>) FROM <name_of_table>;
  
example:
>SELECT date_of_birth, AGE(NOW(), date_of_birth) FROM person;

## CONSTRAINTs:
Adding the constraint:
#### PRIMARY KEY
>ALTER TABLE <name_of_table> ADD CONSTRAINT <name_of_constraint> PRIMARY KEY (<name_of_column>, ... (there can be passed different columns));

example:
>ALTER TABLE person ADD CONSTRAINT primary_key_id PRIMARY KEY (id);
  
Deleting the constraint:
>ALTER TABLE person DROP CONSTRAINT <name_of_constraint> (primary_key_id);

#### UNIQUE
>ALTER TABLE <name_of_table> ADD CONSTRAINT <name_of_constraint> UNIQUE (<name_of_column>, ... (there can be passed different columns));

example:
>ALTER TABLE person ADD CONSTRAINT unique_email UNIQUE (email);

#### CHECK 
>ALTER TABLE <name_of_table> ADD CONSTRAINT <name_of_constraint> CHECK (<name_of_column> = 'Data' OR .... (there can be passed different columns with Data));
  
example:
>ALTER TABLE person ADD CONSTRAINT mark_check CHECK ( mark = 'Mazda' OR mark = 'Ford');

  





