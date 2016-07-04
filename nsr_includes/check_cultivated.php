<?php

////////////////////////////////////////////////////////////////
// Updates cultivated status
//
// Marks species as cultivated (isCultivatedNSR) if the 
// taxon is listed as cultivated anywhere, in any part of
// its range. This does NOT mean that the individual
// plant is necessarily cultivated, rather it is a flag to alert
// the user that species is known to be cultivated
////////////////////////////////////////////////////////////////

//echo "Updating cultivated status...";

$sql="
-- species
UPDATE observation o JOIN cultspp c
ON o.species=c.taxon
SET o.isCultivatedNSR=1
WHERE c.taxon_rank='species'
AND $CACHE_WHERE
;
-- genera
UPDATE observation o JOIN cultspp c
ON o.genus=c.taxon
SET o.isCultivatedNSR=1
WHERE c.taxon_rank='genus'
AND $CACHE_WHERE
;
-- families
UPDATE observation o JOIN cultspp c
ON o.family=c.taxon
SET o.isCultivatedNSR=1
WHERE c.taxon_rank='family'
AND $CACHE_WHERE
;
";
sql_execute_multiple($sql);	


?>