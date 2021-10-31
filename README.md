# Week_7
## DataCamp Completion:
![Joining in SQL](https://github.com/Nik0deemus/Week_7/blob/371a89f4c7171172d023aaf2551db2934a5d5e2e/Joining%20Data%20in%20SQL.PNG)
![Intermediate SQL](https://github.com/Nik0deemus/Week_7/blob/371a89f4c7171172d023aaf2551db2934a5d5e2e/Intermediate%20SQL.PNG)

## What is Auto Incrementing?
An auto increment field is like the index column in Python. You can tell SQL (with various syntax differences for each SQL-handling software) to auto increment your table and that will assign a unique numeric value to each new record. As the name implies, this is done automatically. You can also tweak the number that SQL uses to begin incrementing with. Usually, the increment field is the Primary Key for your table.

## What is the difference between creating a join and creating a subquery?
In SQL, creating a join differs from creating a subquery in several important ways. Primarily, a join allows you to SELECT any column from any of the joined tables. The data is then joined on a particular column value, and the result is displayed as rows of records. With a subquery, you are really just making a nested query and using it as a filter for the records you want to pull from one table.


## In-Class Activity

### 1. ERD
![Grocery Store ERD](https://github.com/Nik0deemus/Week_7/blob/5f8dc53ac405e9886f4193b830c266fd1155cb8a/Grocery%20Store%20Database%20ER%20diagram.svg)

### 2. List of Ways Data Can Be Dirty
i.   white spaces in column names -This can be dealt with by replace or remove '' functions

ii.  missing/duplicate values - python and SQL both have functions to do this: .dropna, .drop_duplicates, .fillna(), etc.

iii. weird characters in data - if this is something like a recurring coma in names, you can use replace or remove like with white spaces

iv.  data formatting/case uniformity - you can use functions like .lower() to change case, or write a conditional format checker

v.   obsolete data left in tables- including a last_update column in your data, then removing data that has not been updated in a given period

vi.  organizational inconsistency - make sure your tables are tidy and you are using accepted best practice and conventions
      
### 3. Exploratory Data Analysis Project...exploration
* APIs from list that intrigue me: NASA - https://api.nasa.gov/, FBI Crime Data API - https://crime-data-explorer.fr.cloud.gov/api
* External API that intereste me: Sweden Statistical Database - https://www.scb.se/en/services/open-data-api/
