--Q1.Assignment 3-5: Using a WHILE Loop Brewbean’s wants to include a feature in
-- its application that calculates the total amount (quantity) of a specified
-- item that can be purchased with a given amount of money. Create a block with
-- a WHILE loop to increment the item’s cost until the dollar value is met.
-- Test first with a total spending amount of $100 and product ID 4. Then test
-- with an amount and a product of your choice. Use initialized variables to
-- provide the total spending amount and product ID.

Declare
 lv_given_money_num number(5,2) := 100;
 lv_item_ID_num number(3) := 4;

 lv_item_qty_num number(3) := 0;
 lv_total_spent_num number(5,2) := 0;
 lv_change_num number(5,2);
 lv_item_price_num bb_product.price%type;
begin
 lv_change_num := lv_given_money_num;
 select price
  into lv_item_price_num
  from bb_product
  where idProduct = lv_item_ID_num;
 while lv_change_num >= lv_item_price_num loop
  lv_item_qty_num := lv_item_qty_num + 1;
  lv_total_spent_num := lv_total_spent_num + lv_item_price_num;
  lv_change_num := lv_change_num - lv_item_price_num;
 end loop;
 dbms_output.put_line('Item ID = ' || lv_item_ID_num);
 dbms_output.put_line('Item price = ' || lv_item_price_num);
 dbms_output.put_line('Given money = ' || lv_given_money_num);
 dbms_output.put_line('Quantity allowed = ' || lv_item_qty_num);
 dbms_output.put_line('Total spend amount = ' || lv_total_spent_num);
 dbms_output.put_line('Change = ' || lv_change_num);
end;
/
--Q2.Assignment 3-6: Working with IF Statements Brewbean’s calculates shipping
-- cost based on the quantity of items in an order. Assume the quantity column
-- in the BB_BASKET table contains the total number of items in a basket.
-- A block is needed to check the quantity provided by an initialized variable
-- and determine the shipping cost. Display the calculated shipping cost onscreen.
-- Test using the basket IDs 5 and 12, and apply the shipping rates listed in
--Table 3-3.
--TABLE 3-3 Shipping Charges
--Quantity of Items Shipping Cost
-->Up to 3 $5.00
-->4–6$7.50
-->7–10 $10.00
-->More than 10 $12.00

Declare
 lv_shipping_cost_num number(4,2);
 lv_basket_ID_num number(3) := 5;

 lv_basket_qty_num bb_basket.quantity%type;
begin
 select quantity
  into lv_basket_qty_num
  from bb_basket
  where idBasket = lv_basket_ID_num;
 if lv_basket_qty_num < 4 then
  lv_shipping_cost_num := 5;
 elsif lv_basket_qty_num < 7 then
  lv_shipping_cost_num := 7.5;
 elsif lv_basket_qty_num < 11 then
  lv_shipping_cost_num := 10;
 else
  lv_shipping_cost_num := 12;
 end if;
 dbms_output.put_line('Basket ID = ' || lv_basket_ID_num);
 dbms_output.put_line('Quantity of items = ' || lv_basket_qty_num);
 dbms_output.put_line('Shipping Cost = ' || lv_shipping_cost_num);
end;

/
--Q3.Assignment 3-7: Using Scalar Variables for Data Retrieval The Brewbean’s
-- application contains a page displaying order summary information, including
-- IDBASKET, SUBTOTAL, SHIPPING, TAX, and TOTAL columns from the BB_BASKET table.
-- Create a PL/SQL block with scalar variables to retrieve this data and then
-- display it onscreen. An initialized variable should provide the IDBASKET value.
-- Test the block using the basket ID 12.

Declare
 lv_basket_ID_num bb_basket.idbasket%type := 12;
 lv_basket_subtotal_num bb_basket.subtotal%type;
 lv_basket_shipping_num bb_basket.shipping%type;
 lv_basket_tax_num bb_basket.tax%type;
 lv_basket_total_num bb_basket.total%type;
begin
 select IDBASKET, SUBTOTAL, SHIPPING, TAX, TOTAL
  into lv_basket_ID_num, lv_basket_subtotal_num, lv_basket_shipping_num,
       lv_basket_tax_num, lv_basket_total_num
  from bb_basket
  where idBasket = lv_basket_ID_num;
 dbms_output.put_line('Basket ID = ' || lv_basket_ID_num);
 dbms_output.put_line('Subtotal = ' || lv_basket_subtotal_num);
 dbms_output.put_line('Shipping = ' || lv_basket_shipping_num);
 dbms_output.put_line('tax = ' || lv_basket_tax_num);
 dbms_output.put_line('total = ' || lv_basket_total_num);
end;

/
--Q4.Assignment 3-8: Using a Record Variable for Data Retrieval The Brewbean’s
-- application contains a page displaying order summary information, including
-- IDBASKET, SUBTOTAL, SHIPPING, TAX, and TOTAL columns from the BB_BASKET table.
-- Create a PL/SQL block with a record variable to retrieve this data and display
-- it onscreen. An initialized variable should provide the IDBASKET value.
-- Test the block using the basket ID 12.
Declare
 lv_basket_ID_num Number(3) := 12;
 type type_basket is record(
  id bb_basket.idbasket%TYPE,
  subtotal bb_basket.subtotal%TYPE,
  shipping bb_basket.shipping%TYPE,
  tax bb_basket.tax%TYPE,
  total bb_basket.total%TYPE);
  rec_basket type_basket;
begin
 select IDBASKET, SUBTOTAL, SHIPPING, TAX, TOTAL
  into rec_basket
  from bb_basket
  where idBasket = lv_basket_ID_num;
 dbms_output.put_line('Basket ID = ' || rec_basket.id);
 dbms_output.put_line('Subtotal = ' || rec_basket.subtotal);
 dbms_output.put_line('Shipping = ' || rec_basket.shipping);
 dbms_output.put_line('tax = ' || rec_basket.tax);
 dbms_output.put_line('total = ' || rec_basket.total);
end;
/
--Q5.Case 3-2: Working with More Movie Rentals. The More Movie Rental Company is
-- developing an application page that displays the total number of times a
-- specified movie has been rented and the associated rental rating based on this
-- count. Table 3-4 shows the rental ratings.
--Create a block that retrieves the movie title and rental count based on a movie
-- ID provided via an initialized variable. The block should display the movie
-- title, rental count, and rental rating onscreen. Add exception handlers for
-- errors you can and can’t anticipate. Run the block with movie IDs of 4 and 25.

--TABLE 3-4 Movie Rental Ratings
--Number of Rentals Rental Rating
--Up to 5 Dump
--5–20 Low
--21–35 Mid
--More than 35 High

Declare
 lv_movie_to_search_num Number(3) := 4;
 
 lv_movie_id_num mm_rental.movie_id%type;
 lv_movie_title mm_movie.movie_title%type;
 lv_movie_count_num number;
 lv_movie_rating_char varchar2(4);
begin
 select mm_rental.movie_id, mm_movie.movie_title, count(mm_rental.movie_id)
  into lv_movie_id_num, lv_movie_title, lv_movie_count_num
  from mm_rental, mm_movie
  where mm_rental.movie_id = lv_movie_to_search_num
   and mm_rental.movie_id = mm_movie.movie_id
  group by mm_rental.movie_id, mm_movie.movie_title;
 if lv_movie_count_num < 5 then
  lv_movie_rating_char := 'Dump';
 elsif lv_movie_count_num < 21 then
  lv_movie_rating_char := 'Low';
 elsif lv_movie_count_num < 36 then
  lv_movie_rating_char := 'Mid';
 else
  lv_movie_rating_char := 'High';
 end if;
 dbms_output.put_line('Movie ID = ' || lv_movie_id_num);
 dbms_output.put_line('Movie Title = ' || lv_movie_title);
 dbms_output.put_line('Movie count = ' || lv_movie_count_num);
 dbms_output.put_line('Movie rating = ' || lv_movie_rating_char);
exception
 when no_data_found then
  dbms_output.put_line('No data found for the following Movie ID = ' || lv_movie_to_search_num);
 when others then
  dbms_output.put_line('Some error has occured');
end;
