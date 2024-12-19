--Name:             Matheus
--Student Number:   301236904
--Assignment:       Final

-- 1.[5 marks] Assignment : Calculating a Shopper’s Total Number of Orders
-- Another commonly used statistic in reports is the total number of orders a
-- shopper has placed. Follow these steps to create a function named
-- NUM_PURCH_SF that accepts a shopper ID and returns a shopper’s total number
-- of orders. Use the function in a SELECT statement to display the number of
-- orders for shopper 23.

--1. Develop and run a CREATE FUNCTION statement to create the NUM_PURCH_SF
-- function. The function code needs totally the number of orders
-- (using an Oracle built-in function) by shopper. Keep in mind that the
-- ORDERPLACED column contains a 1 if an order has been placed.

create or replace function NUM_PURCH_SF
 (p_shopperId in BB_Basket.IDSHOPPER%type)
 return NUMBER
 is
  totalOrders number;
 begin
  select sum(orderPlaced)
   into totalOrders
   from bb_basket
   where BB_basket.idshopper = p_shopperId
   group by IDSHOPPER;
  return totalOrders;
 exception
  when NO_DATA_FOUND then
   dbms_output.put_line('logon values are invalid');
--   shopperID := null;
end NUM_PURCH_SF;
/
-- 2. Create a SELECT query by using the NUM_PURCH_SF function on the IDSHOPPER
-- column of the BB_SHOPPER table. Be sure to select only shopper 23.
select NUM_PURCH_SF(idshopper)
 from bb_shopper
 where idshopper = 23;