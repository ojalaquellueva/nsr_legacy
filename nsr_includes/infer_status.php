<?php

// Hard-wired for now, still needs work


// add remaining indices
$sql="
ALTER TABLE observation
ADD INDEX (native_status_country),
ADD INDEX (native_status_state_province),
ADD INDEX (native_status_reason)
;
";
sql_execute_multiple($sql);

// For now, status at stateProvince level is used only for US and Canada,
// plus Greenland and the stupid French island off of Canada.
// Only country-level status is evaluated for all other countries
//echo "Inferring overall native status...";
$sql="
-- Country-level status
UPDATE observation
SET native_status=
CASE
WHEN native_status_country='A' THEN 'A'
WHEN native_status_country IS NULL THEN 'UNK'
WHEN native_status_country='P' THEN 'P'
ELSE native_status_country
END
WHERE $CACHE_WHERE_NA
;

-- State/province level status
-- Currenly done only for US and Canada
-- Status at this level trumps status at 
-- country level
UPDATE observation
SET native_status=
CASE
WHEN native_status_state_province='A' THEN 'A'
WHEN native_status_state_province='P' THEN 'P'
ELSE native_status_state_province
END
WHERE $CACHE_WHERE_NA
AND state_province IS NOT NULL
AND native_status_state_province IS NOT NULL
AND country IN ('United States','Canada','Denmark','France')
;
";
sql_execute_multiple($sql);

//echo "Populating native status source information...";
$sql="

-- Introduced due to endemism elsewhere
UPDATE observation o JOIN
(
SELECT taxon, o.country, GROUP_CONCAT(DISTINCT source_name SEPARATOR ', ') AS sources
FROM  observation o JOIN distribution d JOIN source s
ON o.species=d.taxon AND d.source_id=s.source_id
WHERE o.native_status='Ie'
GROUP BY taxon, o.country
) AS a
ON o.species=a.taxon AND o.country=a.country
SET o.native_status_reason='Introduced, species endemic to other region',
o.native_status_sources=a.sources
WHERE $CACHE_WHERE
AND o.native_status='Ie'
;

-- Introduced
UPDATE observation o JOIN
(
SELECT taxon, o.country, GROUP_CONCAT(DISTINCT source_name SEPARATOR ', ') AS sources
FROM  observation o JOIN distribution d JOIN source s
ON o.species=d.taxon AND d.source_id=s.source_id
WHERE o.native_status='I'
GROUP BY taxon, o.country
) AS a
ON o.species=a.taxon AND o.country=a.country
SET o.native_status_reason='Introduced to region, as per checklist',
o.native_status_sources=a.sources
WHERE $CACHE_WHERE
AND o.native_status='I'
AND o.native_status_reason IS NULL
;

-- Native
UPDATE observation o JOIN
(
SELECT taxon, o.country, GROUP_CONCAT(DISTINCT source_name SEPARATOR ', ') AS sources
FROM observation o JOIN distribution d JOIN source s
ON o.species=d.taxon AND d.source_id=s.source_id
WHERE o.native_status='N'
GROUP BY taxon, o.country
) AS a
ON o.species=a.taxon AND o.country=a.country
SET o.native_status_reason='Native to region, as per checklist',
o.native_status_sources=a.sources
WHERE $CACHE_WHERE
AND o.native_status='N'
AND o.native_status_reason IS NULL
;

-- Endemic
UPDATE observation o JOIN
(
SELECT taxon, o.country, GROUP_CONCAT(DISTINCT source_name SEPARATOR ', ') AS sources
FROM observation o JOIN distribution d JOIN source s
ON o.species=d.taxon AND d.source_id=s.source_id
WHERE o.native_status='Ne'
GROUP BY taxon, o.country
) AS a
ON o.species=a.taxon AND o.country=a.country
SET o.native_status_reason='Endemic to region, as per checklist',
o.native_status_sources=a.sources
WHERE $CACHE_WHERE
AND o.native_status='Ne'
AND o.native_status_reason IS NULL
;


-- Present, status uncertain
UPDATE observation o JOIN
(
SELECT taxon, o.country, GROUP_CONCAT(DISTINCT source_name SEPARATOR ', ') AS sources
FROM observation o JOIN distribution d JOIN source s
ON o.species=d.taxon AND d.source_id=s.source_id
WHERE o.native_status='P' 
GROUP BY taxon, o.country
) AS a
ON o.species=a.taxon AND o.country=a.country
SET o.native_status_reason='Present in one or more checklists for region, status not indicated',
o.native_status_sources=a.sources
WHERE $CACHE_WHERE
AND o.native_status='P'
AND o.native_status_reason IS NULL
;

-- Absent from region
-- Flag by joining by checklist country
UPDATE observation o JOIN
(
SELECT country, GROUP_CONCAT(DISTINCT source_name SEPARATOR ', ') AS sources
FROM distribution d JOIN source s
ON d.source_id=s.source_id
WHERE is_comprehensive=1
GROUP BY country
) AS a
ON o.country=a.country
SET o.native_status_reason='Absent from all checklists for region',
o.native_status_sources=a.sources
WHERE $CACHE_WHERE
AND o.native_status='A'
;

-- Flag unknowns
UPDATE observation
SET native_status='UNK',
native_status_reason='Status unknown, no checklists for region of observation'
WHERE $CACHE_WHERE_NA
AND native_status='UNK' OR native_status IS NULL
;

-- Provide more details information for observations labeled
-- introduced due to higher taxa elsewhere
UPDATE observation o JOIN
(
SELECT taxon, GROUP_CONCAT(DISTINCT source_name SEPARATOR ', ') AS sources
FROM  observation o JOIN distribution d JOIN source s
ON o.genus=d.taxon AND d.source_id=s.source_id
WHERE o.native_status='Ie' AND d.native_status='endemic'
GROUP BY taxon
) AS a
ON o.genus=a.taxon
SET o.native_status_reason='Introduced, genus endemic to other region',
o.native_status_sources=a.sources
WHERE $CACHE_WHERE
AND o.native_status='Ie' AND native_status_reason IS NULL
;

UPDATE observation o JOIN
(
SELECT taxon, GROUP_CONCAT(DISTINCT source_name SEPARATOR ', ') AS sources
FROM  observation o JOIN distribution d JOIN source s
ON o.family=d.taxon AND d.source_id=s.source_id
WHERE o.native_status='Ie' AND d.native_status='endemic'
GROUP BY taxon
) AS a
ON o.family=a.taxon
SET o.native_status_reason='Introduced, family endemic to other region',
o.native_status_sources=a.sources
WHERE $CACHE_WHERE
AND o.native_status='Ie' AND native_status_reason IS NULL
;

";
sql_execute_multiple($sql);

// These rules should be changed as needed
// The first two updates are uncontroversial, but second
// two should be considered carefully.
// Currently, note that:
// 1. Absence counted as introduced
// 2. Presence counted as native rather than NULL
//echo "Updating isIntroduced...";
$sql="
UPDATE observation
SET isIntroduced=1
WHERE $CACHE_WHERE_NA 
AND native_status IN ('I','Ie')
;
UPDATE observation
SET isIntroduced=0
WHERE $CACHE_WHERE_NA
AND native_status IN ('N','Ne')
;
-- Assume native if present in checklist, without
-- further information
UPDATE observation
SET isIntroduced=0
WHERE $CACHE_WHERE_NA
AND native_status='P'
;
-- Assume introduced if absernt from checklist
UPDATE observation
SET isIntroduced=1
WHERE $CACHE_WHERE_NA
AND native_status='A'
;
";
sql_execute_multiple($sql);

?>