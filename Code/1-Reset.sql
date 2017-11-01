USE adultitemsusa_wp;
DELETE p, pm FROM wp_posts p JOIN wp_postmeta pm ON pm.post_id = p.ID WHERE post_type = "product" OR guid LIKE "[PATH TO IMAGE FOLDER]/%";
																												
DELETE FROM wp_posts WHERE guid LIKE "[PATH TO IMAGE FOLDER]/%";

DELETE t, tm, tt, tr FROM wp_terms t JOIN wp_termmeta tm ON t.term_id = tm.term_id JOIN wp_term_taxonomy tt ON t.term_id = tt.term_id JOIN wp_term_relationships tr ON tt.term_taxonomy_id = tr.term_taxonomy_id;
DELETE FROM wp_termmeta WHERE meta_key = 'tdw_discount_rule';

DELETE FROM wp_posts WHERE post_type = "product";

USE Update_Products;
DELETE FROM products;
DELETE FROM products_description;
DELETE FROM products_to_categories;
DELETE FROM categories_description;
DELETE FROM manufacturers;
DELETE FROM Update_Products;