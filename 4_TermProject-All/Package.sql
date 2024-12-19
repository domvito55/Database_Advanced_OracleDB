--Package
CREATE OR REPLACE PACKAGE SS_Ship_Package AS
-- Procedure to change advertisement name
 PROCEDURE prodname_chg_sp
  (p_id IN ss_advertisement.advertisementid%TYPE,
   p_name IN ss_advertisement.advertisementTitle%TYPE);

-- Procedure to add product in a cartitem table
-- When a qty changes in the cartitem table a trigger updates the cart table
 PROCEDURE SS_AddToCart (
    p_shopperId IN ss_cart.ShopperId%TYPE,
    p_advertisementId IN ss_advertisement.advertisementid%TYPE,
    p_quantity IN ss_cartitem.quantity%TYPE);

  -- Function to calculate shipping cost
 function SS_ShipCost (
     p_price IN NUMBER
 ) Return number;

  -- Function to calculate discounts
 FUNCTION ord_disc_sf1
  (p_id ss_cart.cartid%TYPE)
  RETURN ss_cart.subtotal%TYPE;

END SS_Ship_Package;
/

-- Create or replace the package body
CREATE OR REPLACE PACKAGE BODY SS_Ship_Package AS
-- Procedure to change advertisement name
 PROCEDURE prodname_chg_sp
  (p_id IN ss_advertisement.advertisementid%TYPE,
   p_name IN ss_advertisement.advertisementTitle%TYPE)
  IS
 BEGIN
  UPDATE ss_advertisement
    SET advertisementTitle = p_name
    WHERE advertisementid = p_id;
  COMMIT;
 END;


-- Calculates shipping values based on shipping_table
 function SS_ShipCost (
     p_price IN NUMBER
 ) Return number
 AS
  minPrice ss_shipping.low%type;
  maxPrice ss_shipping.high%type;
  p_ship ss_shipping.fee%type;
 BEGIN
  select min(low), max(high) into minPrice, maxPrice
   from ss_shipping;
  select fee into p_ship
   from ss_shipping
   where (p_price >= low)
    and (p_price <= high);
  return p_ship;  
 EXCEPTION
  When NO_DATA_FOUND THEN
   DBMS_OUTPUT.PUT_LINE('Price out of range: $' || minPrice || ' to $' || maxPrice);
   return 0;
 END;
 
 -- Calculates discounts for orders based on sub total values
 FUNCTION ord_disc_sf1
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

-- Procedure to add product in a cartitem table
-- When a qty changes in the cartitem table a trigger updates the cart table
 PROCEDURE SS_AddToCart (
    p_shopperId IN ss_cart.ShopperId%TYPE,
    p_advertisementId IN ss_advertisement.advertisementid%TYPE,
    p_quantity IN ss_cartitem.quantity%TYPE
 ) AS
    v_cartId ss_cart.cartId%TYPE;
    v_price SS_Advertisement.price%TYPE;
 BEGIN
    -- Check if the shopper has an active cart
    SELECT CartId INTO v_cartId
    FROM SS_Cart
    WHERE (ShopperId = p_shopperId) AND (OrderPlaced = 0);
    dbms_output.put_line(v_cartId);
    IF v_cartId IS NULL THEN
        -- If no active cart, create a new one
        INSERT INTO SS_Cart (CartId, ShopperId, OrderPlaced, dtCreated)
        VALUES (SS_CartId_seq.nextval, p_shopperId, 0, SYSDATE);

        SELECT CartId INTO v_cartId
        FROM SS_Cart
        WHERE (ShopperId = p_shopperId) AND (OrderPlaced = 0);
    END IF;

    -- Check if the item is already in the cart
    SELECT price INTO v_price
    FROM SS_Advertisement
    WHERE AdvertisementId = p_advertisementId;

    IF v_price IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Cart is empty or does not exist.');
    END IF;
    dbms_output.put_line(v_price);

    UPDATE SS_CartItem
    SET Quantity = (Quantity + p_quantity)
    WHERE (CartId = v_cartId) AND (AdvertisementId = p_advertisementId);
    
    IF SQL%NOTFOUND THEN
        -- If the item is not in the cart, insert a new entry
        INSERT INTO SS_CartItem (idCartItem, CartId, AdvertisementId, Quantity, Price)
        VALUES (SS_CartItemId_seq.NEXTVAL, v_cartId, p_advertisementId, p_quantity, v_price);
    END IF;
 END;
 
END SS_Ship_Package;
