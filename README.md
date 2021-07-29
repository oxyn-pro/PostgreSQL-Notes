# Learning_PotgreSQL 

# In order to see the database location on your computer, enter to the psql and type: 
>show data_directory;

# To find out which id illustrates a particular database type in psql:
>SELECT oid AS object_id, datname AS database_name FROM pg_database;

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

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
  
## Date:
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
  
#### AGE function
>SELECT <DATE_collumn>, AGE(NOW(), <DATE_collumn>) FROM <name_of_table>;
  
example:
>SELECT date_of_birth, AGE(NOW(), date_of_birth) FROM person;

## CONSTRAINTs:

#### PRIMARY KEY
Adding the constraint:
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
  
## Handling Exceptions of unique collumns:
>INSERT INTO person (id, mark, model) VALUES (1, 'Mazda', 'Z5') ON CONFLICT (id) DO NOTHING;

#### On Conflict Do Update
>INSERT INTO person (id, mark, model) VALUES (1, 'Ford', 'Mustang') ON CONFLICT (id) DO UPDATE SET mark = EXCLUDED.mark, model = EXCLUDED.model; 
  
## JOIN, LEFT JOIN:
JOIN will display the data of relational tables (i.e. Foreign Key). 
LEFT JOIN display all the data of relational tables (rows) and unrelated tables (with or with not Foreign Key)

example:
>SELECT * FROM person JOIN car ON person.car_id = car.id; ----- # It only works  if both tables are connected to each other and it will display only people with cars (because only people with cars are connected to the 'person' table.
>
>SELECT * FROM person LEFT JOIN car ON person.car_id = car.id; ----- # It only works if both tables are connected to each other and displays all people with or without cars.
  
## Export records into CSV file:
>\copy (SELECT * FROM person) TO (C:/Users/your_user/Desktop) DELIMITER ',' CSV HEADER;
  
## BIGSERIAL 
>SELECT * FROM <name_of_bigserial_table_seq>
>
>SELECT nextval('<name_of_bigserial_table_seq>'::regclass);
>
>ALTER SEQUENCE <name_of_bigserial_table_seq> RESTART WITH 'value';

example:
>SELECT * FROM person_id_seq;
>
>SELECT nextval('person_id_seq'::regclass);
>
>ALTER SEQUENCE person_id_seq RESTART WITH 5;
  
## Extensions (UUID installation):
>SELECT * FROM pg_available_extensions;
>
>CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
>
>SELECT uuid_generate_v4();

## Inserting UUID as ID to tables:
>CREATE TABLE person (person_uid UUID NOT NULL, ...other_collumns );
>
>INSERT INTO person (person_uid, ...other_collumns) VALUES ( uuid_generate_v4(), ...other_collumns);
  
  
# DATABASE DESIGN:
### Every database, table, column, entity, fact must first be organized and drawn (preferably in the form of diagrams) in order to better understand what to work with.
In my case i use this app in order to work with diagrams- https://www.diagrams.net

As an example I took the youtube database creation project (it is very silly, not detailed because i just wanted to construct the general idea of working with PostgreSQL)

![image](https://user-images.githubusercontent.com/69118015/126674794-ccee4814-c468-43d5-a24d-48393b7a59cc.png)

## NORMALIZATION:
## 1NF - 1 Normal Form:
If the values of each atribute, and entity are atomic, it means that they are in 1 Normal Form. If in the attribute there are 2 values/keys/facts they break the rule, meaning that the table is not in 1 Normal Form (AND IT IS VERY BAD PRACTISE!!!). 
  
First normal form tells us to:

- Get rid of non atomic values,
- Get rid of repeating row values,
- Get rid of repeating columns.
  
Attributes should only have single atomic values.
  
example:
![image](https://user-images.githubusercontent.com/69118015/126682843-223d5440-52b3-45ad-9223-8f421db289d3.png)

Here the 'phone_number' violates the 1 Normal Form by having non atomic values inside of 'phone_number' attribute. 
In order to fix it and transform it to 1NF, we need to divide that table into 2 tables by creating a second table called 'phone_number': 
![image](https://user-images.githubusercontent.com/69118015/126684104-be7ec126-01b8-4e07-8016-597dcf9eab23.png)

  
## 2NF - 2 Normal Form
In order to meet requirements of 2NF, the table(s) should:
- first meet requirements of 1NF
- do not have partial dependencies
  
The attribute has a partial dependency to other Primary Key column when it is not directly connected to the required column, meaning that a many-to-many relation of 2 tables 'author' and 'book' have a bridge table called 'book_author' and it can have many attributes like book_id, author_id, but it can also have 'ISBN'(book's unique id) that is incorrect, and in this case, the 'ISBN' has a partial dependency only to 'book_id' because other columns are not relevant to 'ISBN'.
  
![image](https://user-images.githubusercontent.com/69118015/126686430-2a49eef4-0a93-4758-a5f9-b79ea2da763c.png)

In order to transform it we need to first get rid of the partial dependency in our case, which is 'ISBN', and create another table with the primary key 'book_id' (which will also be a foreign key) and with 'ISBN'.
  
  
## 3NF - 3 Normal Form
In order to meet requirements of 3NF, the table(s) should:
- first meet requirements of 2NF
- do not have transitive dependencies (a.k.a no intermideary attribute in one table (it should be transfered to other table))
  
The attribute has a transitive dependency when it is connected to another table which is related to another table(3 -> 2 -> 1). In this situation, there should be created another separate table and transfer the necessary data to that table.
  
![image](https://user-images.githubusercontent.com/69118015/126711013-4aa62057-986c-4999-b6eb-6ad99aaa7869.png)

The solution for this is to divide the table into multiple tables (star), and transfer necessary attributes (star_id, star, star_meaning).
![image](https://user-images.githubusercontent.com/69118015/126711615-ca9c7777-81e6-44c5-9218-940c801dbe56.png)

  
### To sum up:
- 1NF - 1 Normal Form is making everything Atomic
- 2NF - 2 Normal Form is removing Partial Dependecy(s)
- 3NF - 3 Normal Form is removing Transitive Dependency(s)
  
## Final project on Database Design
![2021-07-24_14-42-15](https://user-images.githubusercontent.com/69118015/126864690-b05b719a-9127-4f8a-ab92-4483a5ecc82a.png)

Note: SQL statements(code) is attached in directory section (file name: YouTube_ERD.sql)
  
----------------------------------------------------------------------------------------------------------------------------------------------------------
 
## JOINS (INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN):
#### (INNER) JOIN
>SELECT * FROM <table_name> (INNER) JOIN <other_table> ON <1_table_name>.<column_name> = <2_table_name>.<column_name>;
 
#### LEFT (OUTER) JOIN
>SELECT * FROM <table_name> LEFT (OUTER) JOIN <other_table> ON <1_table_name>.<column_name> = <2_table_name>.<column_name>;
  
#### RIGHT (OUTER) JOIN
>SELECT * FROM <table_name> RIGHT (OUTER) JOIN <other_table> ON <1_table_name>.<column_name> = <2_table_name>.<column_name>;
  
#### FULL JOIN
>SELECT * FROM <table_name> FULL JOIN <other_table> ON <1_table_name>.<column_name> = <2_table_name>.<column_name>;
 
## Transactions:
  
This is very powerful when it comes to the debugging process, because after going through the 1st try, if any errors occur, we can pipe the flow on the 2nd try and end with a COMMIT, or if at least one of them failed, we can just ROLLBACK (return to the initial destination).
  
>BEGIN;
>
>UPDATE accounts SET balance = balance - 200 WHERE id = 1;
>
>UPDATE accounts SET balance = balance + 200 WHERE id = 2;
>
>ROLLBACK "or" COMMIT;

In the above example, we can experiment with 'Transactions', if we start with BEGIN, we can write quires and if one of them fails we can easily ROLLBACK to the initial action, or we everything finishes successfully we can COMMIT the changes, meaning that the changes will be committed to the original/main database. 

## Check all INDEXES of the database
>SELECT tablename, indexname, indexdef FROM pg_indexes WHERE schemaname = <name_of_the_schema> (which is in my case 'public')
  
## Create and Drop INDEXES:
With Indexes Searching the particular information is much faster rather than not having any indexes. 
Let's imagine a book with thousands of pages and each page is an index, without the index finding the specific information will take a lot of time, but if we put/have indexes we can momentarily find the necessary information. 
  
CREATE
>CREATE INDEX <name_of_the_index> ON <table_name>(column_name);
>
DROP
>DROP INDEX <name_of_the_index>;
  
example:
>CREATE INDEX account_name_idx ON account(name);
>
>DROP INDEX account_name_idx;
  
## Create and Drop MULTI-COLUMN-INDEXES:
>CREATE INDEX person_first_name_last_name_idx ON person(first_name, last_name);
>
>DROP INDEX person_first_name_last_name_idx; 
  
Do not forget to follow these rules: 
>SELECT ...... WHERE first_name = <name_first> AND last_name = <name_last>; IS GOOD 
>
>SELECT ...... WHERE first_name = <name_first>; IS GOOD 
>
>SELECT ...... WHERE last_name = <name_last>; IS BAD 
  
## Partial INDEXES:
It is when we want to create an index to the subset of the column

For example:
>CREATE INDEX product_out_of_stock_idx ON product(discontinued) WHERE out_of_stock: 

Right now out_of_stock is True, which means that it will create the index only to the subset of 'out_of_stock' which is 'True'. If we want to change 'True' to 'False, we just need to write '..... WHERE NOT out_of_stock'. 

## Functions:
  
>CREATE OR REPLACE FUNCTION <function_name> (a INT, b TEXT)
>  RETURNS INT 
>  LANGUAGE plqgsql (you can write code in any language: python, java, javascript)
>AS
>$$
>DECLARE
>  --variable_declaration
>  varr INT;
>
>BEGIN 
>   --logic
>END;
>$$
  
example:
>CREATE OR REPLACE FUNCTION count_by_first_name (p_first_name TEXT)
>    RETURNS INT
>    LANGUAGE plpgsql
>AS
>$$
>    DECLARE
>        total INT;
>    BEGIN
>        SELECT COUNT(*) INTO total FROM person WHERE first_name = p_first_name;                     
>        RETURN total;
>    END;
>$$
  
In order to call a function:
>SELECT count_by_first_name(p_first_name: 'Ruby');

