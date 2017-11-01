INSERT INTO Update_Products (Product_ID, Price, Stock_Status, Manufacturers_ID, Featured_Image) 
SELECT products.products_id, products.products_price*1.9, products.products_quantity, products.manufacturers_id, products.products_image 
FROM products;

SELECT '-----------------Products Added' AS '';

UPDATE Update_Products
INNER JOIN products_to_categories ON (Update_Products.Product_ID = products_to_categories.products_id)
SET Update_Products.Category_ID = products_to_categories.categories_id;

SELECT '-----------------Category ID Added' AS '';

UPDATE Update_Products
INNER JOIN categories_description ON (Update_Products.Category_ID = categories_description.categories_id)
SET Update_Products.Category = categories_description.categories_name;

SELECT '-----------------Categories Added' AS '';

UPDATE Update_Products
INNER JOIN products_description ON (Update_Products.Product_ID = products_description.products_id)
SET Update_Products.Product_Name = products_name, Update_Products.Description = products_description.products_description, Update_Products.Excerpt = products_description.item_headline;

SELECT '-----------------Products Details Added' AS '';