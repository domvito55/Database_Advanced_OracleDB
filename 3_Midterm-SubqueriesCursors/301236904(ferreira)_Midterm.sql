--Name:             Matheus
--Student Number:   301236904
--Assignment:       1

COLUMN FULL_NAME FORMAT A15
COLUMN ALIAS FORMAT A15
COLUMN CRIMINAL_NUMBER_OF_VIOLATIONS FORMAT A70
COLUMN CRIMINAL_NUMBER_OF_SENTENCES FORMAT A70
COLUMN CODE_DESCRIPTION FORMAT A18
COLUMN AVG_NUMBER_OF_ASSIGNMENTS FORMAT A26
COLUMN NUMBER_OF_OFFICER_ASSIGNMENTS FORMAT A70
COLUMN AVG_NUMBER_OF_CRIMINALS FORMAT A26
COLUMN NUM_OF_CRIMINALS_PER_OFFICER FORMAT A70

--1. List the name of each officer who has reported min number of crimes officers
--have reported.
with 
 counts_per_officer as
  (select officers.officer_id, count(crime_id) number_of_reports from officers, crime_officers where officers.officer_id = crime_officers.officer_id group by officers.officer_id),
 calculation as
  (select min(number_of_reports) min_number_of_reports from counts_per_officer)
select
  officers.officer_id,
  concat(concat(officers.first, ' '), officers.last) full_name,
  min_number_of_reports,
  number_of_reports
from
  officers,
  counts_per_officer,
  calculation
where
  number_of_reports = min_number_of_reports
  and officers.officer_id = counts_per_officer.officer_id
order by
  officers.officer_id;
/
--2. List the names of probation officers who have had a more or equal than
--average number of criminals assigned.
with 
 counts_per_officer as
  (select prob_officers.prob_id, count(distinct criminal_id) criminals_per_officer from prob_officers, sentences where prob_officers.prob_id = sentences.prob_id group by prob_officers.prob_id),
 calculation as
  (select avg(criminals_per_officer) avg_number_of_criminals from counts_per_officer)
select
  prob_officers.prob_id,
  concat(concat(prob_officers.first, ' '), prob_officers.last) full_name,
  avg_number_of_criminals,
  criminals_per_officer "num_of_criminals_per_officer"
from
  prob_officers,
  counts_per_officer,
  calculation
where
  criminals_per_officer >= avg_number_of_criminals
  and prob_officers.prob_id = counts_per_officer.prob_id
order by
  prob_officers.prob_id;

/
--3. Adding Cursor Flexibility
--An administration page in the DoGood Donor application allows employees to
--enter multiple combinations of *donor type* and *pledge amount* to determine data
--to retrieve. Create a block with a single cursor that allows retrieving data
--and handling multiple combinations of *donor type* and *pledge amount* as input. 
--The *donor name* and *pledge amount* should be retrieved and displayed for each
--pledge that matches the donor type and is greater than the *pledge amount 
--indicated*.

-- *Use a collection to provide the input data.*

--Test the block using
--the following input data. Keep in mind that these inputs should be processed
--with one execution of the block. The donor type code I represents Individual,
--and B represents Business. Both has to be executed in one run of code.
--Donor Type --- Pledge Amount
--I 250
--B 500
DECLARE
 TYPE type_search IS RECORD
  (donorType dd_donor.typecode%TYPE,
  amount dd_pledge.pledgeamt%TYPE);
-- rec_search type_search;
 
 TYPE type_searchTable IS TABLE OF type_search
  INDEX BY BINARY_INTEGER;
 tbl_search type_searchTable;

 CURSOR cur_donor (rec_search type_search) IS
  SELECT p.pledgeamt, iddonor, d.firstname, d.lastname, d.typecode
   FROM dd_pledge p INNER JOIN dd_donor d
    USING (iddonor)
   where d.typecode = rec_search.donorType
    and p.pledgeamt > rec_search.amount
   order by iddonor;
BEGIN
 tbl_search(1).donorType := 'I';
 tbl_search(1).amount := 250;
 tbl_search(2).donorType := 'B';
 tbl_search(2).amount := 500;

 FOR i IN 1..tbl_search.COUNT LOOP
  For rec_donor in cur_donor(tbl_search(i)) LOOP
   DBMS_OUTPUT.PUT_LINE(tbl_search(i).donorType || ' ' || tbl_search(i).amount ||
                        ' ' || rec_donor.iddonor || ' ' || rec_donor.firstname ||
                        ' ' || rec_donor.lastname ||  ' ' ||rec_donor.pledgeamt);
  END LOOP;
 END LOOP;
END;
