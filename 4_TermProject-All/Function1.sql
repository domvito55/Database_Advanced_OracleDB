-- Calculates shipping values based on shipping_table
CREATE OR REPLACE function SS_ShipCost (
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
/

-- Test valid data
DECLARE
    v_shippingFee ss_shipping.fee%type;
BEGIN
    v_shippingFee := SS_ShipCost(-1);
    DBMS_OUTPUT.PUT_LINE('Shipping Fee: ' || v_shippingFee);
END;
