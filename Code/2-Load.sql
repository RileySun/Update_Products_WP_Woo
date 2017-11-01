LOAD DATA LOCAL INFILE "/home/Update_Products/Base/categories_description.csv"
INTO TABLE categories_description
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE "/home/Update_Products/Base/manufacturers.csv"
INTO TABLE manufacturers
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE "/home/Update_Products/Base/products.csv"
INTO TABLE products
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE "/home/Update_Products/Base/products_description.csv"
INTO TABLE products_description
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE "/home/Update_Products/Base/products_to_categories.csv"
INTO TABLE products_to_categories
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;