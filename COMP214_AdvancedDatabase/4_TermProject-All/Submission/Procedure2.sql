-- Procedure to change advertisement name
CREATE OR REPLACE PROCEDURE prodname_chg_sp
  (p_id IN ss_advertisement.advertisementid%TYPE,
   p_name IN ss_advertisement.advertisementTitle%TYPE)
  IS
BEGIN
  UPDATE ss_advertisement
    SET advertisementTitle = p_name
    WHERE advertisementid = p_id;
  COMMIT;
END;
/
BEGIN
 prodname_chg_sp(2001,'The Lord of The rings');
END;
/
SELECT advertisementid, advertisementTitle
  FROM ss_advertisement
  WHERE advertisementid = 2001;