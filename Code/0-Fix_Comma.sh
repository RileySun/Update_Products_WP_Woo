#!/bin/bash

#Remove Stray Commas From CSV
cat /home/Update_Products/Base/products_descriptionR.csv | awk -F'"' -v OFS='' '{ for (i=2; i<=NF; i+=2) gsub(",", "", $i) } 1' > /home/Update_Products/Base/products_description.csv;
cat /home/Update_Products/Base/categories_descriptionR.csv | awk -F'"' -v OFS='' '{ for (i=2; i<=NF; i+=2) gsub(",", "", $i) } 1' > /home/Update_Products/Base/categories_description.csv;
cat /home/Update_Products/Base/productsR.csv | awk -F'"' -v OFS='' '{ for (i=2; i<=NF; i+=2) gsub(",", "", $i) } 1' > /home/Update_Products/Base/products.csv;