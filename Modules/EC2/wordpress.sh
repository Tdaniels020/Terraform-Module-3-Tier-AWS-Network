<<<<<<< HEAD
#!/bin/bash
#Bash script to install and configure wordpress
#######################################
# Section 1
#Installation requirements
#update system
echo "updating OS"
sudo yum update -y
wait
echo "your OS was successfully updates"
#Installation of Appache server
echo "Installing apache server"
sudo yum install -y httpd
wait
echo "Apache was successfully installed on your system"
#Installation of php
echo "Installing php"
sudo yum install -y amazon-linux-extras
wait
echo "php was successfully installed"
#Enabling php7.4
sudo amazon-linux-extras enable php7.4
echo "php7.4 was successfully enabled"
#cleaning matadata
echo "Cleaning matadata"
sudo yum clean metadata
wait
echo "matadata was successfully cleaned"
#Installation of php libraries
echo "Installing php libraries"
sudo yum install -y php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap}
wait
echo "php libraries were successfully installed"
# Installation of mysql
echo "Installing mysql repo packages"
sudo yum install -y https://repo.mysql.com//mysql80-community-release-el7-5.noarch.rpm
wait
echo "mysql was successfully installed"
# Installing mysql server"
echo "Installing mysql server"
sudo yum install mysql-server -y
wait
echo "mysql server was successfully installed"
# Installation of wget
echo "Installing wget"
sudo yum install wget -y
wait
echo "wget successfully installed"
# Installation of wordpress
echo "Changing Directory to var/www/html/"
cd /var/www/html/
echo "Downloading wordpress"
sudo wget http://wordpress.org/latest.tar.gz
wait
echo "Extracting wordpress"
sudo tar -xzf latest.tar.gz
echo "Changing directory to wordpress"
cd wordpress/
# Move wordpress to document root
echo "moving wordpress to document root"
sudo mv wp-config-sample.php wp-config.php
echo "wordpress was sucessfully installed"
# Setting permissions to wordpress directories
echo "changing ownership of apache to var/www"
sudo chown -R apache /var/www
echo "changing group permission of apache to var/www"
sudo chgrp -R apache /var/www
echo "Modifying permission of apache to var/www"
sudo chmod 2775 /var/www
# Set permissions on files and directories
echo "setting permissions on files and directories"
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;
echo "Permissions were successfully changed"
# Restart apache and mysqld
echo "Restarting and enabling apache and mysqld services"
sudo service restart httpd
sudo service enable httpd
sudo service restart mysqld
sudo service enable mysqld
echo "httpd and mysqld were successfully restarted"
echo "Testing components"
sudo service status mysqld 
sudo service status httpd
sudo php --version
sudo yum install tree -y 
wait
sudo ls -la /var/www/html/wordpress
wait
sudo tree /var/www/html/
echo "section completed successfully"

###################################################
# Section 2 Setting Up Wordpress on Amazon Linux 2
###################################################
## Ask value for mysql root password and DB name
#mysqlRootPass="$(pwmake 32)"
mysqlRootPass="yn!APF5087RTd"
dbpass="w!GTRDBHYFDer45"
wordpress_db_name="finishline-db"
dbuser="finishline"
#read -p 'wordpress_db_name [wp_db]: ' wordpress_db_name
#read -p 'dbuser [wp_db_User]: ' dbuser
#read -p 'db_root_password [only-alphanumeric]: ' db_root_password

## Check Current directory
pwd=$(pwd)

## Starting mysql server (first run)'
tempRootDBPass="`sudo grep 'temporary.*root@localhost' /var/log/mysqld.log | tail -n 1 | sed 's/.*root@localhost: //'`"

## Setting up new mysql server root password'
sudo service stop mysqld.service
sudo rm -rf /var/lib/mysql/*logfile*
sudo service start mysqld.service
sudo mysqladmin -u root --password="$tempRootDBPass" password "$mysqlRootPass"
sudo mysql -u root --password="$mysqlRootPass" -e <<-EOSQL
    DELETE FROM mysql.user WHERE User='';
    DROP DATABASE IF EXISTS test;
    DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
    DELETE FROM mysql.user where user != 'mysql.sys';
    CREATE USER 'root'@'%' IDENTIFIED BY '${mysqlRootPass}';
    GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
EOSQL
sudo service status mysqld.service

## Configure WordPress Database
mysql -uroot -p$mysqlRootPass <<QUERY_INPUT
CREATE USER '$dbuser'@'localhost' IDENTIFIED BY '$dbpass';
CREATE DATABASE $wordpress_db_name;
GRANT ALL PRIVILEGES ON $wordpress_db_name.* TO '$dbuser'@'localhost';
FLUSH PRIVILEGES;
EXIT
QUERY_INPUT

## Add Database Credentias in wordpress
cd /var/www/html/wordpress
sudo perl -pi -e "s/database_name_here/$wordpress_db_name/g" wp-config.php
sudo perl -pi -e "s/username_here/$dbuser/g" wp-config.php
sudo perl -pi -e "s/password_here/$dbpass/g" wp-config.php

## Restart Apache and Mysql
sudo service restart httpd
sudo service restart mysqld

## Cleaning Download
cd ..
sudo rm -rf latest.tar.gz 

echo "Wordpress username is $dbuser and wordpressdb password is $dbpass  last mysql root password is $mysqlRootPass"
=======
#!/bin/bash
#Bash script to install and configure wordpress
#######################################
# Section 1
#Installation requirements
#update system
echo "updating OS"
sudo yum update -y
wait
echo "your OS was successfully updates"
#Installation of Appache server
echo "Installing apache server"
sudo yum install -y httpd
wait
echo "Apache was successfully installed on your system"
#Installation of php
echo "Installing php"
sudo yum install -y amazon-linux-extras
wait
echo "php was successfully installed"
#Enabling php7.4
sudo amazon-linux-extras enable php7.4
echo "php7.4 was successfully enabled"
#cleaning matadata
echo "Cleaning matadata"
sudo yum clean metadata
wait
echo "matadata was successfully cleaned"
#Installation of php libraries
echo "Installing php libraries"
sudo yum install -y php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap}
wait
echo "php libraries were successfully installed"
# Installation of mysql
echo "Installing mysql repo packages"
sudo yum install -y https://repo.mysql.com//mysql80-community-release-el7-5.noarch.rpm
wait
echo "mysql was successfully installed"
# Installing mysql server"
echo "Installing mysql server"
sudo yum install mysql-server -y
wait
echo "mysql server was successfully installed"
# Installation of wget
echo "Installing wget"
sudo yum install wget -y
wait
echo "wget successfully installed"
# Installation of wordpress
echo "Changing Directory to var/www/html/"
cd /var/www/html/
echo "Downloading wordpress"
sudo wget http://wordpress.org/latest.tar.gz
wait
echo "Extracting wordpress"
sudo tar -xzf latest.tar.gz
echo "Changing directory to wordpress"
cd wordpress/
# Move wordpress to document root
echo "moving wordpress to document root"
sudo mv wp-config-sample.php wp-config.php
echo "wordpress was sucessfully installed"
# Setting permissions to wordpress directories
echo "changing ownership of apache to var/www"
sudo chown -R apache /var/www
echo "changing group permission of apache to var/www"
sudo chgrp -R apache /var/www
echo "Modifying permission of apache to var/www"
sudo chmod 2775 /var/www
# Set permissions on files and directories
echo "setting permissions on files and directories"
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;
echo "Permissions were successfully changed"
# Restart apache and mysqld
echo "Restarting and enabling apache and mysqld services"
sudo service restart httpd
sudo service enable httpd
sudo service restart mysqld
sudo service enable mysqld
echo "httpd and mysqld were successfully restarted"
echo "Testing components"
sudo service status mysqld 
sudo service status httpd
sudo php --version
sudo yum install tree -y 
wait
sudo ls -la /var/www/html/wordpress
wait
sudo tree /var/www/html/
echo "section completed successfully"

###################################################
# Section 2 Setting Up Wordpress on Amazon Linux 2
###################################################
## Ask value for mysql root password and DB name
#mysqlRootPass="$(pwmake 32)"
mysqlRootPass="yn!APF5087RTd"
dbpass="w!GTRDBHYFDer45"
wordpress_db_name="finishline-db"
dbuser="finishline"
#read -p 'wordpress_db_name [wp_db]: ' wordpress_db_name
#read -p 'dbuser [wp_db_User]: ' dbuser
#read -p 'db_root_password [only-alphanumeric]: ' db_root_password

## Check Current directory
pwd=$(pwd)

## Starting mysql server (first run)'
tempRootDBPass="`sudo grep 'temporary.*root@localhost' /var/log/mysqld.log | tail -n 1 | sed 's/.*root@localhost: //'`"

## Setting up new mysql server root password'
sudo service stop mysqld.service
sudo rm -rf /var/lib/mysql/*logfile*
sudo service start mysqld.service
sudo mysqladmin -u root --password="$tempRootDBPass" password "$mysqlRootPass"
sudo mysql -u root --password="$mysqlRootPass" -e <<-EOSQL
    DELETE FROM mysql.user WHERE User='';
    DROP DATABASE IF EXISTS test;
    DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
    DELETE FROM mysql.user where user != 'mysql.sys';
    CREATE USER 'root'@'%' IDENTIFIED BY '${mysqlRootPass}';
    GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
EOSQL
sudo service status mysqld.service

## Configure WordPress Database
mysql -uroot -p$mysqlRootPass <<QUERY_INPUT
CREATE USER '$dbuser'@'localhost' IDENTIFIED BY '$dbpass';
CREATE DATABASE $wordpress_db_name;
GRANT ALL PRIVILEGES ON $wordpress_db_name.* TO '$dbuser'@'localhost';
FLUSH PRIVILEGES;
EXIT
QUERY_INPUT

## Add Database Credentias in wordpress
cd /var/www/html/wordpress
sudo perl -pi -e "s/database_name_here/$wordpress_db_name/g" wp-config.php
sudo perl -pi -e "s/username_here/$dbuser/g" wp-config.php
sudo perl -pi -e "s/password_here/$dbpass/g" wp-config.php

## Restart Apache and Mysql
sudo service restart httpd
sudo service restart mysqld

## Cleaning Download
cd ..
sudo rm -rf latest.tar.gz 

echo "Wordpress username is $dbuser and wordpressdb password is $dbpass  last mysql root password is $mysqlRootPass"
>>>>>>> f770621744f127974709d4cec0899755a4b29912
echo "Congratulations your Installation is complete have a yummy day!"