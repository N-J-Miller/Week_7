# Week_7

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
