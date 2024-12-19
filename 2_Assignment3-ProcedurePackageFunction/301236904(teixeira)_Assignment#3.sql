ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YY';
--  Q1: Assignment : Create a procedure named STATUS_SHIP_SP that allows an
--employee in the Shipping Department to update an order status to add shipping
--information.
--  The BB_BASKETSTATUS table lists events for each order so that a shopper can
--see the current status, date, and comments as each stage of the order process
--is finished. The IDSTAGE column of the BB_BASKETSTATUS table identifies each
--stage; the value 3 in this column indicates that an order has been shipped.
--  The procedure should allow adding a row with an IDSTAGE of 3, date shipped,
--tracking number, and shipper. The BB_STATUS_SEQ sequence is used to provide a
--value for the primary key column. Test the procedure with the following
--information:
--Basket # = 3 Date shipped = 20-FEB-12 Shipper = UPS Tracking # = ZW2384YXK4957
Create or replace procedure STATUS_SHIP_SP
 (basket# in bb_basketstatus.idbasket%type,
  dateShipped in bb_basketstatus.dtstage%type,
  shipper in bb_basketstatus.shipper%type,
  notes in bb_basketstatus.notes%type,
  tracking# in bb_basketstatus.shippingnum%type
 ) is
 begin
  INSERT INTO bb_basketstatus (idstatus, idbasket, idstage, dtstage, notes,
                               shipper, shippingnum
                              )
   VALUES (BB_STATUS_SEQ.nextval, basket#, 3, dateShipped, notes, shipper,
           tracking#
          );
end STATUS_SHIP_SP;
/
begin
 STATUS_SHIP_SP
 (basket# =>3,
  dateShipped => '20-FEB-12',
  shipper => 'UPS',
  notes => '',
  tracking# => 'ZW2384YXK4957'
 );
end;
/
select * from BB_BASKETSTATUS where BB_BASKETSTATUS.IDBASKET = 3;


--  Q2: Assignment : Returning Order Status Information
--  Create a procedure that returns the most recent order status information for
--a specified basket.
--  This procedure should determine the most recent ordering-stage entry in the
--BB_BASKETSTATUS table and return the data.
--  Use an IF or CASE clause to return a stage description instead of an IDSTAGE
--number, which means little to shoppers. The IDSTAGE column of the
--BB_BASKETSTATUS table identifies each stage as follows:
--  • 1—Submitted and received
--  • 2—Confirmed, processed, sent to shipping
--  • 3—Shipped
--  • 4—Cancelled
--  • 5—Back-ordered
--  The procedure should accept a basket ID number and return the most recent
--status description and date the status was recorded. If no status is available
--for the specified basket ID, return a message stating that no status is
--available. Name the procedure STATUS_SP. Test the procedure twice with the
--basket ID 4 and then 6.
Create or replace procedure STATUS_SP
 (basket# in bb_basketstatus.idbasket%type,
  statusDescritpion out varchar2,
  dateRecorded out date
 ) is
  idStage BB_BASKETSTATUS.IDSTAGE%type;
 begin
  with most as
   (select max(DTSTAGE) recentDate from BB_BASKETSTATUS where IDBASKET = basket#)
  select IDSTAGE, DTSTAGE
   into idStage, dateRecorded
   from BB_BASKETSTATUS, most
   where IDBASKET = basket#
    and DTSTAGE = most.recentDate;
  CASE IDSTAGE
   WHEN 1 THEN statusDescritpion := 'Submitted and received';
   WHEN 2 THEN statusDescritpion := 'Confirmed, processed, sent to shipping';
   WHEN 3 THEN statusDescritpion := 'Shipped';
   WHEN 4 THEN statusDescritpion := 'Cancelled';
   WHEN 5 THEN statusDescritpion := 'Back-ordered';
  END case;
  Exception
   when NO_DATA_FOUND then
    statusDescritpion := 'No status is available';
    dateRecorded := '';
end STATUS_SP;
/
declare
 basket# BB_BASKETSTATUS.IDBASKET%type := 4;
 statusDescritpion varchar2(40);
 dateRecorded BB_BASKETSTATUS.DTSTAGE%type;
begin
 while basket# < 7 loop
  STATUS_SP (basket# => basket#,
             statusDescritpion => statusDescritpion,
             dateRecorded => dateRecorded
            );
  dbms_output.put_line('basket# = ' || basket#);
  dbms_output.put_line('statusDescritpion = ' || statusDescritpion);
  dbms_output.put_line('dateRecorded = ' || dateRecorded);
  dbms_output.put_line('################################');
  dbms_output.put_line('');
  basket# := basket# + 2;
 end loop;
end;
/

--  Q3: Assignment : Identifying Customers Brewbean’s wants to offer an
--incentive of free shipping to customers who haven’t returned to the site since
--a specified date.
--  Create a procedure named PROMO_SHIP_SP that determines who these customers
--are and then updates the BB_PROMOLIST table accordingly.
--  The procedure uses the following information:
--  • Date cutoff—Any customers who haven’t shopped on the site since this date
--should be included as incentive participants. Use the basket creation date to
--reflect shopper activity dates.
--  • Month—A three-character month (such as APR) should be added to the
--promotion table to indicate which month free shipping is effective.
--  • Year—A four-digit year indicates the year the promotion is effective.
--  • promo_flag—1 represents free shipping.
--  The BB_PROMOLIST table also has a USED column, which contains the default
--value N and is updated to Y when the shopper uses the promotion.
--  Test the procedure with the cutoff date 15-FEB-12.
-- Assign free shipping for the month APR and the year 2012.
Create or replace procedure PROMO_SHIP_SP
 (cutOff in BB_BASKET.DTCREATED%type,
  freeMonth in bb_promolist.month%type,
  freeYear in bb_promolist.year%type
 ) is
  CURSOR cur_idShopper IS
  SELECT IDSHOPPER, max(DTCREATED) mostRecentBuy
   FROM BB_BASKET group by IDSHOPPER;
 begin
  For shopper in cur_idShopper LOOP
   if shopper.mostRecentBuy < cutOff then
    INSERT INTO bb_promolist (idshopper, month, year, promo_flag, used
                             )
     VALUES (shopper.idshopper, freeMonth, freeYear, 1, 'N'
            );
   end if;
  END LOOP;
End PROMO_SHIP_SP;
/
begin
 PROMO_SHIP_SP
 (cutOff => '15-FEB-12',
  freeMonth => 'APR',
  freeYear => '2012'
 );
end;
/
select * from BB_PROMOLIST;

--  Q4: Assignment : Using Packaged Variables
--  In this assignment, you create a package that uses packaged variables to
--assist in the user logon process.
--  When a returning shopper logs on, the username and password entered need to
--be verified against the database. In addition, two values need to be stored in
--packaged variables for reference during the user session: the shopper ID and
--the first three digits of the shopper’s zip code (used for regional
--advertisements displayed on the site).
--1.	Create a function that accepts a username and password as arguments and
--verifies these values against the database for a match.
--If a match is found, return the value Y.
--Set the value of the variable holding the return value to N.
--Include a NO_DATA_FOUND exception handler to display a message that the logon
--values are invalid. 
--2.	 Use an anonymous block to test the procedure, using the username gma1
--and the password goofy. 
--3.	 Now place the function in a package, and add code to create and
--populate the packaged variables specified earlier. Name the package LOGIN_PKG. 
--4.	 Use an anonymous block to test the packaged procedure, using the
--username gma1 and the password goofy to verify that the procedure works
--correctly. 
--5.	 Use DBMS_OUTPUT statements in an anonymous block to display the values
--stored in the packaged variables.
create or replace package LOGIN_PKG
 is
  shopperID BB_SHOPPER.IDSHOPPER%type := null;
  zip varchar2(3) := null;
  function loginCheck
   (p_username in BB_SHOPPER.USERNAME%type, userPassword in BB_SHOPPER.PASSWORD%type)
   return char;
end LOGIN_PKG;
/
create or replace package body LOGIN_PKG
 is
  function loginCheck
   (p_username in BB_SHOPPER.USERNAME%type, userPassword in BB_SHOPPER.PASSWORD%type)
   return char
   is
    valid char(1) := 'N';
   begin
    select 'Y', BB_SHOPPER.IDSHOPPER, substr(BB_SHOPPER.ZIPCODE,1,3)
     into valid, shopperID, zip
     from BB_SHOPPER
     where BB_SHOPPER.USERNAME = p_username
      and BB_SHOPPER.PASSWORD = userPassword;
    return valid;
   exception
    when NO_DATA_FOUND then
     dbms_output.put_line('logon values are invalid');
     shopperID := null;
     zip := null;
     return valid;
  end loginCheck;
end;
/
declare
 valid char(1);
begin
 valid := LOGIN_PKG.loginCheck('gma1', 'goofy');
 dbms_output.put_line('valid = ' || valid);
 dbms_output.put_line('shopperID = ' || LOGIN_PKG.shopperID);
 dbms_output.put_line('zip = ' || LOGIN_PKG.zip);
 dbms_output.put_line('#############');
end;  
 
/
--  Q5: Assignment : Using a Cursor in a Package
--  In this assignment, you work with the sales tax computation because the
--Brewbean’s lead programmer expects the rates and states applying the tax to
--undergo some changes. The tax rates are currently stored in packaged variables
--but need to be more dynamic to handle the expected changes.
--  The lead programmer has asked you to develop a package that holds the tax
--rates by state in a packaged cursor.
--  The BB_TAX table is updated as needed to reflect which states are applying
--sales tax and at what rates.
--This package should contain a function that can receive a two-character state
--abbreviation (the shopper’s state) as an argument, and it must be able to find
--a match in the cursor and return the correct tax rate.
--Use an anonymous block to test the function with the state value NC.
create or replace package TAX_PKG
 is
  CURSOR cur_tax IS
   SELECT BB_TAX.STATE state, BB_TAX.TAXRATE taxRate
    FROM BB_TAX;
  function getEstateRate
   (p_state BB_TAX.STATE%type)
   return BB_TAX.TAXRATE%type;
end TAX_PKG;
/
create or replace package body TAX_PKG
 is
  function getEstateRate
   (p_state BB_TAX.STATE%type)
   return BB_TAX.TAXRATE%type
   is
   begin
    For currentRow in cur_tax LOOP
     if currentRow.state = p_state then
      return currentRow.taxRate;
     end if;
    END LOOP;
   end getEstateRate;
end;
/
declare
 rate BB_TAX.TAXRATE%type;
begin
 rate := TAX_PKG.getEstateRate('NC');
 dbms_output.put_line('State = NC');
 dbms_output.put_line('Rate = ' || rate);
 dbms_output.put_line('#############');
end;  
