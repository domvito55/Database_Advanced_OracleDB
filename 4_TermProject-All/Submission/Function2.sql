-- Calculates discounts for orders based on sub total values
CREATE OR REPLACE FUNCTION ord_disc_sf1
  (p_id ss_cart.cartid%TYPE)
  RETURN ss_cart.subtotal%TYPE
 IS
  lv_sub_num ss_cart.subtotal%TYPE;
BEGIN
  SELECT subtotal
   INTO lv_sub_num
   FROM ss_cart
   WHERE cartid = p_id;
  IF lv_sub_num >= 1000 THEN
    RETURN lv_sub_num * .20;
  ELSIF lv_sub_num >= 500 THEN
    RETURN lv_sub_num * .10;
  ELSIF lv_sub_num >= 250 THEN
    RETURN lv_sub_num * .05;
  ELSE
    RETURN 0;
  END IF;
EXCEPTION
 When NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Cart id doesn''t exist');
    return 0;  
END;
/
DECLARE
  lv_id_num NUMBER := 4003;
  lv_disc_num NUMBER;
BEGIN
  lv_disc_num := ord_disc_sf1(lv_id_num);
  DBMS_OUTPUT.PUT_LINE('Discount: $' || lv_disc_num);
END;
