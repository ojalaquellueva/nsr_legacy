<?

///////////////////////////////////////////////////////////
// Appends any new records from observation table to cache
///////////////////////////////////////////////////////////

$sql="
ALTER TABLE observation
ADD INDEX (is_in_cache);

INSERT INTO cache (
family,
genus,
species,
country,
state_province,
county_parish,
native_status_country,
native_status_state_province,
native_status_county_parish,
native_status,
native_status_reason,
native_status_sources,
isIntroduced,
isCultivatedNSR
)
SELECT
family,
genus,
species,
country,
state_province,
county_parish,
native_status_country,
native_status_state_province,
native_status_county_parish,
native_status,
native_status_reason,
native_status_sources,
isIntroduced,
isCultivatedNSR
FROM observation
WHERE is_in_cache=0
;

";
sql_execute_multiple($sql);

?>