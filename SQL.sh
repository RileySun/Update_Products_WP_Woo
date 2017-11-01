#!/bin/sh
myLogin="mysql -u [USER_NAME] --password=[PASSWORD] Update_Products"
bash /home/Update_Products/Code/0-Fix_Comma.sh;
echo "#######--Fixed Syntax Errors In Catalogue--#######";
$myLogin < /home/Update_Products/Code/1-Reset.sql;
echo "#######--Reset Tables For Fresh Data--#######";
$myLogin < /home/Update_Products/Code/2-Load.sql;
echo "#######--Loaded Tables From Catalogue--#######";
$myLogin < /home/Update_Products/Code/3-Clean.sql;
echo "#######--Cleaned Data Of Null Values--#######";
$myLogin < /home/Update_Products/Code/4-Join.sql;
echo -e "\n#######--Created Final Export Table--#######";
$myLogin < /home/Update_Products/Code/5-Sanitize.sql;
echo "#######--Final Table Sanitized--#######";
echo -e "\n#######--BEGIN WORDPRESS IMPORT--#######";
php /home/Update_Products/Code/6-Import.php
echo "#######--END WORDPRESS IMPORT--#######";