<?php
	$connect = mysqli_connect("localhost", "[MYSQL USER]", "[MYSQL PASSWORD]", "[WORDPRESS TABLE]");
	$count = 0;
	
	if (!$connect) {
		die('Could not connect: ' . mysqli_connect_errno($connect));
	}
	
	function createImage($connect, $IMAGE) {
		$sql = "INSERT INTO wp_posts (post_type, guid, post_status, post_mime_type) VALUES ('attachment', '[PATH TO IMAGE FOLDER]".$IMAGE."', 'publish', 'image/jpeg');";
		mysqli_query($connect, $sql);
	}
	
	function getImageID($connect, $IMAGE) {
		$sql = "SELECT * FROM wp_posts WHERE guid = '[PATH TO IMAGE FOLDER]".$IMAGE."';";
		$result = mysqli_query($connect, $sql);
		$row = $result->fetch_assoc();
		return $row['ID'];
	}
	
	function assignImage($connect, $IMAGE, $ID) {
		$image_id = getImageID($connect, $IMAGE);
		
		$sql2 = "INSERT INTO wp_postmeta (post_id, meta_key, meta_value) VALUES (".$image_id.", '_wp_attached_file', '[PATH TO IMAGE FOLDER]".$IMAGE."');";
		mysqli_query($connect, $sql2);
		
		$sql3 = "INSERT INTO wp_postmeta (post_id, meta_key, meta_value) VALUES (".$ID.", '_thumbnail_id', ".$image_id.");";
		mysqli_query($connect, $sql3);
	}
	
	function createProducts($connect, $NAME, $PRICE, $DESCRIPTION, $EXCERPT, $SKU) {
		$NAME = mysqli_real_escape_string($connect, $NAME);
		$SLUG = preg_replace('/[^A-Za-z0-9-]+/', '-', strtolower($NAME));
		$sql = 'INSERT INTO wp_posts (post_author,  post_date,  post_date_gmt,  post_content,  post_title,  post_excerpt,  post_status,  comment_status,  ping_status,  post_name, post_modified,  post_modified_gmt,  post_parent,  guid,  menu_order,  post_type,  comment_count) VALUES (1, NOW(), NOW(), "'.$DESCRIPTION.'", "'.$NAME.'", "'.$EXCERPT.'", "publish", "open", "closed", "'.$SLUG.'", NOW(), NOW(), 0, CONCAT("[WEBSITE URL]/product/", "'.$SLUG.'", "/"), 0, "product", 0);';
		mysqli_query($connect, $sql);
		
		$postID = getPostID($connect, $NAME);
		
		$meta1 = "INSERT INTO wp_postmeta (post_id, meta_key, meta_value) VALUES (".$postID.", '_price', ".$PRICE.");";
		$meta2 = "INSERT INTO wp_postmeta (post_id, meta_key, meta_value) VALUES (".$postID.", '_sku', '".$SKU."');";
		$meta3 = "INSERT INTO wp_postmeta (post_id, meta_key, meta_value) VALUES (".$postID.", '_regular_price', ".$PRICE.");";
		$meta4 = "INSERT INTO wp_postmeta (post_id, meta_key, meta_value) VALUES (".$postID.", '_stock_status', 'instock');";
		mysqli_query($connect, $meta1);
		mysqli_query($connect, $meta2);
		mysqli_query($connect, $meta3);
		mysqli_query($connect, $meta4);
	}
	
	function getPostID($connect, $NAME) {
		$sql = "SELECT ID FROM wp_posts WHERE post_title = '".$NAME."';";
		$result = mysqli_query($connect, $sql);
		if ($result->num_rows > 0) {
			$row = $result->fetch_assoc();
			return $row['ID'];
		}
		else {
			echo "Post Not Found - Name: ".$NAME;
			exit;
		}
	}
	
	function checkCat($connect, $CATEGORY) {
		$sql0 = "SELECT * FROM wp_term_taxonomy JOIN wp_terms ON wp_term_taxonomy.term_id = wp_terms.term_id  WHERE wp_term_taxonomy.taxonomy = 'product_cat';";
		$result0 = mysqli_query($connect, $sql0);
		
		if ($result0->num_rows > 0) {
			$BOOL = false;
			while($row0 = $result0->fetch_assoc()) {
				if ($CATEGORY == $row0['name']) {
					$BOOL = true;
				}
			}
			return $BOOL;
		}
	} //True if Exists
	
	function createCat($connect , $POST_ID, $CATEGORY, $IMAGE) {
		$CATSLUG = preg_replace('/[^A-Za-z0-9-]+/', '-', strtolower($CATEGORY));
		
		if (checkCat($connect, $CATEGORY)) {
			$sql1A = "SELECT term_id FROM wp_terms WHERE slug = '".$CATSLUG."';";
			$result1 = mysqli_query($connect, $sql1A);
			$row1 = $result1->fetch_assoc();
			$TERM_ID = $row1['term_id'];
			
			$sql2 = "UPDATE wp_term_taxonomy SET count = count + 1 WHERE term_id = ".$TERM_ID.";";
			mysqli_query($connect, $sql2);
		}
		else {
			$sql1 = "INSERT INTO wp_terms (name, slug, term_group) VALUES ('".$CATEGORY."', '".$CATSLUG."', 0);";
			mysqli_query($connect, $sql1);
		
			$sql1A = "SELECT term_id FROM wp_terms WHERE slug = '".$CATSLUG."';";
			$result1 = mysqli_query($connect, $sql1A);
			$row1 = $result1->fetch_assoc();
			$TERM_ID = $row1['term_id'];
		
			$sql2 = "INSERT INTO wp_termmeta (term_id, meta_key, meta_value) VALUES (".$TERM_ID.", 'product_count_product_cat', 1);";
			mysqli_query($connect, $sql2);
			
			$imageID = getImageID($connect, $IMAGE);
			$sql3 = "INSERT INTO wp_termmeta (term_id, meta_key, meta_value) VALUES (".$TERM_ID.", 'thumbnail_id', ".$imageID.");";
			mysqli_query($connect, $sql3);
		
			$sql4 = "INSERT INTO wp_term_taxonomy (term_id, taxonomy, parent, count) VALUES (".$TERM_ID.", 'product_cat', 0, 1);";
			mysqli_query($connect, $sql4);
			
			$discount = "a:10:{s:7:\"min-qtt\";d:0;s:5:\"value\";i:15;s:8:\"aggr-var\";b:0;s:8:\"priority\";i:1;s:4:\"type\";s:10:\"percentage\";s:6:\"active\";b:1;s:14:\"disable_coupon\";b:1;s:8:\"taxonomy\";s:11:\"product_cat\";s:4:\"from\";s:0:\"\";s:2:\"to\";s:0:\"\";}";
			$sql5 = "INSERT INTO wp_termmeta (term_id, meta_key, meta_value) VALUES (".$TERM_ID.", 'tdw_discount_rule', '".$discount."');";
			mysqli_query($connect, $sql5);
		}
		
		$sql3A = "SELECT term_taxonomy_id FROM wp_term_taxonomy WHERE term_id = ".$TERM_ID.";";
		$result3 = mysqli_query($connect, $sql3A);
		$row3 = $result3->fetch_assoc();
		$TAXONOMY_ID = $row3['term_taxonomy_id'];
		
		$sql4 = "INSERT INTO wp_term_relationships (object_id, term_taxonomy_id) VALUES (".$POST_ID.", ".$TAXONOMY_ID.");";
		mysqli_query($connect, $sql4);
	}
	
	function getProducts($connect, $count) {
		$then = time();
		$sql0 = "USE Update_Products;";
		mysqli_query($connect, $sql0);
		$sql = "SELECT * FROM Update_Products;";
		$result = mysqli_query($connect, $sql);
		if ($result->num_rows > 0) {
			$sqlSwitch = "USE adultitemsusa_wp";
			mysqli_query($connect, $sqlSwitch);
			while($row = $result->fetch_assoc()) {
				createImage($connect, $row['Featured_Image']);
				createProducts($connect, $row['Product_Name'], $row['Price'], $row['Description'], $row['Excerpt'], $row['SKU']);
				$postID = getPostID($connect, $row['Product_Name']);
				assignImage($connect, $row['Featured_Image'], $postID);
				createCat($connect , $postID, $row['Category'], $row['Featured_Image']);
				$count = $count + 1;
			}
			$now = time();
			$time = $now - $then;
			echo "\t".$count." Products Added in ".round(($time/60), 2)." min (".$time." sec)\n";
		}
		else {
			echo "Error: No Products";
		};
	}
	
	getProducts($connect, $count);
	
?>