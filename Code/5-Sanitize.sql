DELETE FROM Update_Products WHERE Product_Name IS NULL;
DELETE FROM Update_Products WHERE Category IS NULL;
/*Description*/
UPDATE Update_Products SET Description = REPLACE(Description, '&Acirc;', '') WHERE Description like '%&Acirc;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&amp;', '&') WHERE Description like '%&amp;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&cent;', '¢') WHERE Description like '%&cent;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&frac14;', '¼') WHERE Description like '%&frac14;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&frac12;', '½') WHERE Description like '%&frac12;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&frac34;', '¾') WHERE Description like '%&frac34;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&iexcl;', '¡') WHERE Description like '%&iexcl;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&Atilde;', 'Ã') WHERE Description like '%&Atilde;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&uml;', '') WHERE Description like '%&uml;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&lt;', '<') WHERE Description like '%&lt;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&gt;', '>') WHERE Description like '%&gt;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&not;', '') WHERE Description like '%&not;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&iuml;', '') WHERE Description like '%&iuml;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&nbsp;', ' ') WHERE Description like '%&nbsp;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&reg;', '®') WHERE Description like '%&reg;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&sup3;', '³') WHERE Description like '%&sup3;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&copy;', '©') WHERE Description like '%&copy;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&brvbar;', '') WHERE Description like '%&brvbar;%';
UPDATE Update_Products SET Description = REPLACE(Description, '-', '&#45;') WHERE Description like '%-%';
UPDATE Update_Products SET Description = REPLACE(Description, "'", '&#39;') WHERE Description like "%'%";
UPDATE Update_Products SET Description = REPLACE(Description, '/', '&#47;') WHERE Description like '%/%';
UPDATE Update_Products SET Description = REPLACE(Description, '"', '&quot;') WHERE Description like '%"%';
/*Name*/
UPDATE Update_Products SET Product_Name = REPLACE(Product_Name, '&amp;', '&') WHERE Product_Name like '%&amp;%';
UPDATE Update_Products SET Product_Name = REPLACE(Product_Name, '&Atilde;', 'Ã') WHERE Product_Name like '%&Atilde;%';
UPDATE Update_Products SET Product_Name = REPLACE(Product_Name, '&copy;', '©') WHERE Product_Name like '%&copy;%';
UPDATE Update_Products SET Product_Name = REPLACE(Product_Name, "'", '&#39;') WHERE Product_Name like "%'%";
UPDATE Update_Products SET Product_Name = REPLACE(Product_Name, ' - ', '&#45;') WHERE Product_Name like '% - %';
UPDATE Update_Products SET Product_Name = REPLACE(Product_Name, '/', '&#47;') WHERE Product_Name like '%/%';
/*Excerpt*/
UPDATE Update_Products SET Excerpt = REPLACE(Excerpt, '-', '&#45;') WHERE Excerpt like '%-%';
UPDATE Update_Products SET Excerpt = REPLACE(Excerpt, '/', '&#47;') WHERE Excerpt like '%/%';
/*Category*/
UPDATE Update_Products SET Category = REPLACE(Category, '-', '&#45;') WHERE Category like '%-%';
/*Unused
UPDATE Update_Products SET Description = REPLACE(Description, '&#039;', "'") WHERE Description like '%&#039;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&quot;', '"') WHERE Description like '%&quot;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&acirc;', '"') WHERE Description like '%&acirc;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&lsquo;', "'") WHERE Description like '%&lsquo;%';
UPDATE Update_Products SET Description = REPLACE(Description, '&rsquo;', "'") WHERE Description like '%&rsquo;%';
UPDATE Update_Products SET Product_Name = REPLACE(Product_Name, '&#039;', "'") WHERE Product_Name like '%&#039;%';
UPDATE Update_Products SET Product_Name = REPLACE(Product_Name, '&quot;', '"') WHERE Product_Name like '%&quot;%';
*/