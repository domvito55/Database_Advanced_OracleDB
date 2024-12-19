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

--1.List of criminals with less than average violations and having aliases.
with 
  total_per_criminal as
    (select criminals.criminal_id, sum(violations) number_of_violations from sentences, criminals where criminals.criminal_id = sentences.criminal_id group by criminals.criminal_id),
  calculation as
    (select round(avg(nvl(number_of_violations,0)),3) avg_number_of_violations from total_per_criminal)
select
  aliases.criminal_id,
  concat(concat(criminals.first, ' '), criminals.last) full_name,
  alias,
  avg_number_of_violations,
  nvl(to_char(number_of_violations),'0. No sentence was ever issued to this criminal; therefore, 0 violations. Sentences table does not mention this criminal') criminal_number_of_violations
from
  aliases,
  criminals,
  total_per_criminal,
  calculation
where
  nvl(number_of_violations,0) < avg_number_of_violations
  and aliases.criminal_id = criminals.criminal_id
  and criminals.criminal_id = total_per_criminal.criminal_id (+)
order by
  criminals.criminal_id;
--2.List criminal(s) that Crime charges court fee is greater than min per crime.
with 
  calculation as
    (select min(court_fee) min_fee_per_crime from crime_charges)
select
  criminal_id,
  concat(concat(criminals.first, ' '), criminals.last) full_name,
  court_fee,
  crime_code,
  code_description,
  min_fee_per_crime
from
  crime_charges natural join
  crimes  natural join
  crime_codes natural join
  criminals natural join
  calculation
where
  crime_charges.court_fee > min_fee_per_crime
order by
  criminal_id;

--3.List Officers that have less of equal avg number of crimes assigned.
with 
 counts_per_officer as
  (select officers.officer_id, count(crime_id) number_of_assignments from officers, crime_officers where officers.officer_id = crime_officers.officer_id group by officers.officer_id),
 calculation as
  (select avg(number_of_assignments) avg_number_of_assignments from counts_per_officer)
select
  officers.officer_id,
  concat(concat(officers.first, ' '), officers.last) full_name,
  avg_number_of_assignments,
  number_of_assignments number_of_officer_assignments
from
  officers,
  counts_per_officer,
  calculation
where
  number_of_assignments <= avg_number_of_assignments
  and officers.officer_id = counts_per_officer.officer_id (+)
order by
  officers.officer_id;

--4.List criminals that have Max amount paid in crime charges per crime.
with 
 calculation as
      (select max(amount_paid) max_paid_per_crime from crime_charges)
select criminal_id,
        concat(concat(criminals.first, ' '), criminals.last) full_name,
        amount_paid,
        crime_code,
        code_description,
        max_paid_per_crime
from crime_charges natural join
    crimes  natural join
    crime_codes natural join
    criminals natural join
    calculation
where crime_charges.amount_paid = max_paid_per_crime
order by
  criminal_id;

--5.List criminals that have less or equal than average sentences issued.
with 
  total_per_criminal as
    (select criminals.criminal_id, (sentences.end_date-sentences.start_date) sentence_length from sentences, criminals where criminals.criminal_id = sentences.criminal_id),
  calculation as
    (select round(avg(sentence_length),2) avg_sentence_length from total_per_criminal)
select
  criminal_id,
  concat(concat(criminals.first, ' '), criminals.last) full_name,
  avg_sentence_length,
  sentence_length  
from
  criminals natural join
  total_per_criminal,
  calculation
where
  sentence_length <= avg_sentence_length
order by
  criminal_id;

--6.List probation officers that have less than average criminals with sentences assigned with them.
with 
 counts_per_officer as
  (select prob_officers.prob_id, count(distinct criminal_id) criminals_per_officer from prob_officers, sentences where prob_officers.prob_id = sentences.prob_id group by prob_officers.prob_id),
 calculation as
  (select avg(criminals_per_officer) avg_number_of_criminals from counts_per_officer)
select
  prob_officers.prob_id,
  concat(concat(prob_officers.first, ' '), prob_officers.last) full_name,
  avg_number_of_criminals,
  criminals_per_officer num_of_criminals_per_officer
from
  prob_officers,
  counts_per_officer,
  calculation
where
  criminals_per_officer <= avg_number_of_criminals
  and prob_officers.prob_id = counts_per_officer.prob_id
order by
  prob_officers.prob_id;
