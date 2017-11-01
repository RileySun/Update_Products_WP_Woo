#!/bin/sh
SECONDS=0;
echo -e "\n\n"
date
echo "********STARTING UPDATE PROGRAM********"

# Remove Old Files
rm -fr /home/Update_Products/Base
rm -fr /var/www/html/wp-content/uploads/images
mkdir /home/Update_Products/Base
mkdir /var/www/html/wp-content/uploads/images
echo "Removed Old Update Files"

# Download CSV
curl -sS ftp://[DROPSHIP FTP PATH]/exports/full/products.csv --user [DROPSHIP USERNAME]:[DROPSHIP PASSWORD] -o /home/Update_Products/Base/productsR.csv 
curl -sS ftp://[DROPSHIP FTP PATH]/exports/full/products_description.csv --user [DROPSHIP USERNAME]:[DROPSHIP PASSWORD] -o /home/Update_Products/Base/products_descriptionR.csv
curl -sS ftp://[DROPSHIP FTP PATH]/exports/full/products_to_categories.csv --user [DROPSHIP USERNAME]:[DROPSHIP PASSWORD] -o /home/Update_Products/Base/products_to_categories.csv
curl -sS ftp://[DROPSHIP FTP PATH]/exports/full/categories_description.csv --user [DROPSHIP USERNAME]:[DROPSHIP PASSWORD] -o /home/Update_Products/Base/categories_descriptionR.csv
curl -sS ftp://[DROPSHIP FTP PATH]/exports/full/manufacturers.csv --user [DROPSHIP USERNAME]:[DROPSHIP PASSWORD] -o /home/Update_Products/Base/manufacturers.csv
echo "Downloaded Product Catalog"

# Download Images
curl -sS ftp://[DROPSHIP FTP PATH]/images/imageDirMedium.zip --user [DROPSHIP USERNAME]:[DROPSHIP PASSWORD] -o /var/www/html/wp-content/uploads/images/images.zip
echo "Downloaded Product Images"

# Unzip Images and Delete Archive
unzip -q /var/www/html/wp-content/uploads/images/images.zip -d /var/www/html/wp-content/uploads/images
rm -rf /var/www/html/wp-content/uploads/images/images.zip
echo "Unpacked Images & Deleted Archive"

# The Main Function
bash /home/Update_Products/SQL.sh
echo -e "\n Update Process Took $(($SECONDS/60)) min ($SECONDS sec)"
echo "*********ENDING UPDATE PROGRAM*********"
exit