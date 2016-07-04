<?php

include "db_configw.php";
include "db_connect.php";

if ($echo_on) echo "Creating table observation..."; 
$sql="
DROP TABLE IF EXISTS observation;


CREATE TABLE observation (
id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
family VARCHAR(50) DEFAULT NULL,
genus VARCHAR(50) DEFAULT NULL,
species VARCHAR(150) DEFAULT NULL,
country VARCHAR(50) DEFAULT NULL,
state_province VARCHAR(50) DEFAULT NULL,
county_parish VARCHAR(50) DEFAULT NULL,
user_id INT(11) UNSIGNED DEFAULT NULL,
native_status_country VARCHAR(25) DEFAULT NULL,
native_status_state_province VARCHAR(25) DEFAULT NULL,
native_status_county_parish VARCHAR(25) DEFAULT NULL,
native_status VARCHAR(25) DEFAULT NULL,
native_status_reason VARCHAR(250) DEFAULT NULL,
native_status_sources VARCHAR(250) DEFAULT NULL,
isIntroduced INT(1) DEFAULT NULL,
isCultivatedNSR INT(1) UNSIGNED DEFAULT 0,
is_in_cache INT(11) UNSIGNED DEFAULT 0,
PRIMARY KEY (id)
);

";
sql_execute_multiple($sql);
if ($echo_on) echo $done;

?>