-- Update the ss_cart table when there is modification on ss_cartitem
CREATE OR REPLACE TRIGGER ss_cartItem_trg
   AFTER INSERT OR DELETE OR UPDATE OF quantity ON ss_cartitem
   FOR EACH ROW
BEGIN
 IF INSERTING THEN
  UPDATE ss_cart
   SET quantity = quantity + :NEW.quantity,
     subtotal = subtotal + (:NEW.price*:NEW.quantity),
     shipping = SS_Ship_Package.ss_shipcost(subtotal + (:NEW.price*:NEW.quantity)),
     tax = (subtotal + (:NEW.price*:NEW.quantity) + SS_Ship_Package.ss_shipcost(subtotal + (:NEW.price*:NEW.quantity))) * 0.13,
     total = 
       subtotal + (:NEW.price*:NEW.quantity) +
       SS_Ship_Package.ss_shipcost(subtotal + (:NEW.price*:NEW.quantity)) +
       (subtotal + (:NEW.price*:NEW.quantity) + SS_Ship_Package.ss_shipcost(subtotal + (:NEW.price*:NEW.quantity))) * 0.13
    WHERE cartid = :NEW.cartid;
 ELSIF DELETING THEN
  UPDATE ss_cart
   SET quantity = quantity - :OLD.quantity,
     subtotal = subtotal - (:OLD.price*:OLD.quantity),
     shipping = SS_Ship_Package.ss_shipcost(subtotal - (:OLD.price*:OLD.quantity)),
     tax = (subtotal - (:OLD.price*:OLD.quantity) + SS_Ship_Package.ss_shipcost(subtotal - (:OLD.price*:OLD.quantity))) * 0.13,
     total = subtotal - (:OLD.price*:OLD.quantity) +
       SS_Ship_Package.ss_shipcost(subtotal - (:OLD.price*:OLD.quantity)) +
       (subtotal - (:OLD.price*:OLD.quantity) + SS_Ship_Package.ss_shipcost(subtotal - (:OLD.price*:OLD.quantity))) * 0.13
    WHERE cartid = :OLD.cartid;
 ELSIF UPDATING THEN
  UPDATE ss_cart
   SET quantity = quantity + (:NEW.quantity - :OLD.quantity),
     subtotal = subtotal + (:OLD.price*(:NEW.quantity - :OLD.quantity)),
     shipping = SS_Ship_Package.ss_shipcost(subtotal + (:OLD.price*(:NEW.quantity - :OLD.quantity))),
     tax = 0.13 * (subtotal + (:OLD.price*(:NEW.quantity - :OLD.quantity)) +
           SS_Ship_Package.ss_shipcost(subtotal + (:OLD.price*(:NEW.quantity - :OLD.quantity)))),
     total = subtotal + (:OLD.price*(:NEW.quantity - :OLD.quantity)) +
             SS_Ship_Package.ss_shipcost(subtotal + (:OLD.price*(:NEW.quantity - :OLD.quantity))) +
             0.13 * (subtotal + (:OLD.price*(:NEW.quantity - :OLD.quantity)) +
             SS_Ship_Package.ss_shipcost(subtotal + (:OLD.price*(:NEW.quantity - :OLD.quantity))))
    WHERE cartid = :OLD.cartid;
 END IF;
END;
/

-- Testes
--select ss_cartitem.*,
--  ss_cart.quantity as "cart quantity",
--  ss_cart.subtotal as "cart subtotal",
--  ss_cart.shipping as "cart shipping",
--  ss_cart.tax as "cart tax",
--  ss_cart.total as "cart total"
-- from ss_cartitem, ss_cart
-- where ss_cartitem.cartid = 4001
--  and ss_cartitem.cartid = ss_cart.cartid;
--
----delete from ss_cartitem
---- where idcartitem = 5015;
----Add
--INSERT INTO ss_cartitem (idcartitem, advertisementid, cartid, quantity, price)
--  VALUES (5014, 2001, 4001, 2, 100);
--select ss_cartitem.*,
--  ss_cart.quantity as "cart quantity",
--  ss_cart.subtotal as "cart subtotal",
--  ss_cart.shipping as "cart shipping",
--  ss_cart.tax as "cart tax",
--  ss_cart.total as "cart total"
-- from ss_cartitem, ss_cart
-- where ss_cartitem.cartid = 4001
--  and ss_cartitem.cartid = ss_cart.cartid;
--
--select sum(quantity*price) from ss_cartitem
-- where cartid = 4002;
--
--select sum(quantity) from ss_cartitem
-- where cartid = 4002;
--
--
----increase qty of item
--UPDATE ss_cartitem
--  SET quantity = 3
--  WHERE idcartitem = 5014;
--select ss_cartitem.*,
--  ss_cart.quantity as "cart quantity",
--  ss_cart.subtotal as "cart subtotal",
--  ss_cart.shipping as "cart shipping",
--  ss_cart.tax as "cart tax",
--  ss_cart.total as "cart total"
-- from ss_cartitem, ss_cart
-- where ss_cartitem.cartid = 4001
--  and ss_cartitem.cartid = ss_cart.cartid;
--
----decrease qty of item
--UPDATE ss_cartitem
--  SET quantity = 2
--  WHERE idcartitem = 5014;
--select ss_cartitem.*,
--  ss_cart.quantity as "cart quantity",
--  ss_cart.subtotal as "cart subtotal",
--  ss_cart.shipping as "cart shipping",
--  ss_cart.tax as "cart tax",
--  ss_cart.total as "cart total"
-- from ss_cartitem, ss_cart
-- where ss_cartitem.cartid = 4001
--  and ss_cartitem.cartid = ss_cart.cartid;
--
----remove item
--DELETE FROM ss_cartitem
--  WHERE idcartitem = 5014;
--select ss_cartitem.*,
--  ss_cart.quantity as "cart quantity",
--  ss_cart.subtotal as "cart subtotal",
--  ss_cart.shipping as "cart shipping",
--  ss_cart.tax as "cart tax",
--  ss_cart.total as "cart total"
-- from ss_cartitem, ss_cart
-- where ss_cartitem.cartid = 4001
--  and ss_cartitem.cartid = ss_cart.cartid;
--
----ROLLBACK;
----ALTER TRIGGER ss_cartItem_trg DISABLE;