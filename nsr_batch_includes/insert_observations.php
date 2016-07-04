<?php

if ($echo_on) echo "Inserting observations...";

// insert the raw records
$sql="
INSERT INTO observation (
family,
genus,
species,
country,
state_province,
county_parish,
user_id
)
SELECT 
family,
genus,
species,
country,
state_province,
county_parish,
user_id
FROM observation_raw
;

";
sql_execute_multiple($sql);

// Index observation
$sql="
ALTER TABLE observation
ADD INDEX (family),
ADD INDEX (genus),
ADD INDEX (species),
ADD INDEX (country),
ADD INDEX (state_province),
ADD INDEX (county_parish)
;

UPDATE observation 
SET state_province=NULL
WHERE state_province='';

UPDATE observation 
SET county_parish=NULL
WHERE county_parish='';

";
sql_execute_multiple($sql);

// Drop the raw table
$sql="
-- DROP TABLE IF EXISTS observation_raw;
";
sql_execute_multiple($sql);

if ($echo_on) echo "done\r\n";

?>