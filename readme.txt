BIEN Native Status Resolver (NSR)

For an observation of a taxon within a political division:

taxon, country, [state_province], [county_parish]

returns an opinion as to whether the taxon is native or introduced to that political division.

Observations are evaluated with respect to regional checklists in the NSR database. If not checklist is available for the region submitted, the NSR returns no opinion. 

The NSR consists uses php and mysql, and consists of three applications run by the following "master scripts", which call all others:

1. create_nsr.php
- Build complete NSR database from scratch, using sources provided
- Currently in /home/boyle/nsr/

2. nsr_ws.php
- NSR web service
- Processes on observation at a time
- In this directory, var/www/bien/apps/nsr/.

3. nsr_batch.php
- NSR batch processing application
- Processes multiple observations at once
- Observations are submitted as a text file
- Requires shell access to this server
- In this directory, var/www/bien/apps/nsr/.

In addition, the NSR batch application can be accessed from a user interface on the bien website, which submits input from a html form completed by the user.


