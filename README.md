CRM
===

CRM and ERP base

Install
===
mysql -e "Create database crm"
mysql -e "CREATE USER 'crm'@'localhost' IDENTIFIED BY 'crm'"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'crm'@'localhost' WITH GRANT OPTION"
mysql -e "FLush PRIVILEGES"

mysql -u crm -pcrm crm < crm_database.sql
mysql -u crm -pcrm crm < authTable.sql
mysql -u crm -pcrm crm -e "insert into virtual_domains (id,name) values(1,'demo');"
mysql -u crm -pcrm crm -e "insert into virtual_user (user,password,domain_id) values('demo','fe01ce2a7fbac8fafaed7c982a04e229',1);"


on Web CRM
login: demo
pass: demo
