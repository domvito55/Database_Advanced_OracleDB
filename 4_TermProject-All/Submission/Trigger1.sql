-- Trigger to update stocks of the advertisements
CREATE OR REPLACE TRIGGER product_inventory_trg
 AFTER UPDATE OF orderplaced ON ss_cart
 FOR EACH ROW
 WHEN (OLD.orderplaced <> 1 AND NEW.orderplaced = 1)
DECLARE
 CURSOR cartitem_cur IS
 SELECT advertisementid, quantity
  FROM ss_cartitem
  WHERE cartid = :NEW.cartid;
 lv_chg_num NUMBER(3,1);
BEGIN
 FOR cartitem_rec IN cartitem_cur LOOP
   lv_chg_num := cartitem_rec.quantity;
  UPDATE ss_advertisement
   SET stock = stock - lv_chg_num
   WHERE advertisementid = cartitem_rec.advertisementid;
 END LOOP;
END;

--Testes
--/
--select ss_cart.cartid, ss_cart.quantity, ss_cart.orderplaced, ss_cartitem.advertisementid, stock
-- from ss_cart, ss_cartitem, ss_advertisement
-- where ss_cart.cartid = 4003
--  and ss_cartitem.cartid = ss_cart.cartid
--  and ss_advertisement.advertisementid = ss_cartitem.advertisementid;
--/
--BEGIN
--   UPDATE ss_cart
--   SET orderplaced = 1
--   WHERE cartid = 4003;
--END;
--/
--select ss_cart.cartid, ss_cart.quantity, ss_cart.orderplaced, ss_cartitem.advertisementid, stock
-- from ss_cart, ss_cartitem, ss_advertisement
-- where ss_cart.cartid = 4003
--  and ss_cartitem.cartid = ss_cart.cartid
--  and ss_advertisement.advertisementid = ss_cartitem.advertisementid;
