-- ################### Cleaning database ####################
DROP TABLE SS_category CASCADE CONSTRAINTS;
DROP TABLE SS_Advertisement CASCADE CONSTRAINTS;
DROP TABLE SS_Shopper CASCADE CONSTRAINTS;
DROP TABLE SS_Cart CASCADE CONSTRAINTS;
DROP TABLE SS_CartItem CASCADE CONSTRAINTS;
DROP TABLE SS_Shipping CASCADE CONSTRAINTS;
DROP TABLE SS_CartStatus CASCADE CONSTRAINTS;
DROP TABLE SS_Cat_Sales CASCADE CONSTRAINTS;
DROP TABLE SS_Shop_Sales CASCADE CONSTRAINTS;
DROP TABLE SS_Audit_Logon CASCADE CONSTRAINTS;

DROP SEQUENCE SS_categoryId_seq;
DROP SEQUENCE SS_advertisementId_seq;
DROP SEQUENCE SS_shopper_seq;
DROP SEQUENCE SS_CartId_seq;
DROP SEQUENCE SS_CartItemId_seq;
DROP SEQUENCE SS_RangeId_seq;
DROP SEQUENCE SS_Status_seq;
DROP SEQUENCE SS_Cat_Sales_seq;

-- ################### Category ####################
CREATE SEQUENCE SS_categoryId_seq start with 1001;
--###########Table 1###########
CREATE TABLE SS_category (
	categoryId number(4),
	categoryName varchar2(25),
	categoryDesc varchar2(100),
	CONSTRAINT cat_id_pk PRIMARY KEY(categoryId) );
insert into SS_category 
   values(SS_categoryId_seq.nextval,'Art','Painting, Sculpture, and more');
insert into SS_category 
   values(SS_categoryId_seq.nextval,'Books','Textbooks, magazines, romances, and more');
insert into SS_category 
   values(SS_categoryId_seq.nextval,'Clothes','Shirts, pants, underwear, and more');
insert into SS_category 
   values(SS_categoryId_seq.nextval,'Eletronics','Computers, cellphones, and more');
insert into SS_category 
   values(SS_categoryId_seq.nextval,'Furniture','Sofas, beds, tables, and more');
insert into SS_category 
   values(SS_categoryId_seq.nextval,'Musical Instruments','Guitars, Pianos, Drums, and more');
insert into SS_category 
   values(SS_categoryId_seq.nextval,'Real State','Houses, apartments, offices, and more for buy or rent');
insert into SS_category 
   values(SS_categoryId_seq.nextval,'Tools','cars, motorcycles, bicycles, and more');
insert into SS_category 
   values(SS_categoryId_seq.nextval,'Toys','Board games, dolls, video games, and more');
insert into SS_category 
   values(SS_categoryId_seq.nextval,'Vehicles','Cars, motorcycles, bicycles, and more');

-- ################### Advertisement ####################
CREATE SEQUENCE SS_advertisementId_seq start with 2001;
--###########Table 2###########
CREATE TABLE SS_Advertisement (
	advertisementId number,
	advertisementTitle varchar2(25) ,
	advertisementDescription varchar2(200) ,
	advertisementImage blob,
	price number(10,2),
    sold char(1),
	active char(1),
    new char(1),
	saleStart date,
	saleEnd date,
	salePrice number(6,2),
	stock number(5),
    idcategory number(4),
	 CONSTRAINT advertisement_id_pk PRIMARY KEY(advertisementId),
         CONSTRAINT advertisement_idCategory_fk FOREIGN KEY (idcategory)
           REFERENCES SS_category (categoryId) );

INSERT INTO SS_Advertisement (advertisementId, advertisementTitle, advertisementDescription, advertisementImage, price, sold, active, new, saleStart, saleEnd, salePrice, stock, idcategory)
VALUES (SS_advertisementId_seq.nextval,'Rich Dad Poor Dad','Rich Dad Poor Dad is the #1 personal finance book of all time. 
 Buy today to set yourself up for a wealthy, happy future.',EMPTY_BLOB(), 100, 'N', 'Y', 'Y', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 89.99, 100, 1002);

INSERT INTO SS_Advertisement (advertisementId, advertisementTitle, advertisementDescription, advertisementImage, price, sold, active, new, saleStart, saleEnd, salePrice, stock, idcategory)
VALUES (SS_advertisementId_seq.nextval,'Nike Air Jordan 1','Own the OG Nike Sneakers in white.',
EMPTY_BLOB(), 150, 'N', 'Y', 'Y', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 129.99, 200, 1003);

INSERT INTO SS_Advertisement (advertisementId, advertisementTitle, advertisementDescription, advertisementImage, price, sold, active, new, saleStart, saleEnd, salePrice, stock, idcategory)
VALUES (SS_advertisementId_seq.nextval,'Adidas track pants','Meet your new favorite track pants. These adidas Firebird track pants were made for icons',
EMPTY_BLOB(), 100, 'N', 'Y', 'Y', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 89.99, 100, 1003);

INSERT INTO SS_Advertisement (advertisementId, advertisementTitle, advertisementDescription, advertisementImage, price, sold, active, new, saleStart, saleEnd, salePrice, stock, idcategory)
VALUES (SS_advertisementId_seq.nextval,'Airpods 2nd Gen','These airpods are almost as good as new ones. They work perfectly.',
EMPTY_BLOB(), 60, 'N', 'Y', 'N', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 59.99, 1, 1004);

INSERT INTO SS_Advertisement (advertisementId, advertisementTitle, advertisementDescription, advertisementImage, price, sold, active, new, saleStart, saleEnd, salePrice, stock, idcategory)
VALUES (SS_advertisementId_seq.nextval,'Bed Mattress','Used for an year and a half. The mattress is very comfortable and has minimal stains.',
EMPTY_BLOB(), 40, 'N', 'Y', 'N', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 39.99, 2, 1005);

INSERT INTO SS_Advertisement (advertisementId, advertisementTitle, advertisementDescription, advertisementImage, price, sold, active, new, saleStart, saleEnd, salePrice, stock, idcategory)
VALUES (SS_advertisementId_seq.nextval,'Honda Civic 2016','2016 built Honda Civic. Blue color. Used for 109k kms.',
EMPTY_BLOB(), 10000, 'N', 'Y', 'N', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 8889.99, 1, 1010);

INSERT INTO SS_Advertisement (advertisementId, advertisementTitle, advertisementDescription, advertisementImage, price, sold, active, new, saleStart, saleEnd, salePrice, stock, idcategory)
VALUES (SS_advertisementId_seq.nextval,'Barbie doll','New Barbie merchandise from Mattel. Exclusive to Canada.',
EMPTY_BLOB(), 70, 'N', 'Y', 'Y', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 69.99, 75, 1009);

INSERT INTO SS_Advertisement (advertisementId, advertisementTitle, advertisementDescription, advertisementImage, price, sold, active, new, saleStart, saleEnd, salePrice, stock, idcategory)
VALUES (SS_advertisementId_seq.nextval,'Drilling Machine','My old drilling machine is up for sale because I do not use it no more.',
EMPTY_BLOB(), 40, 'N', 'Y', 'N', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 35.99, 1, 1008);

INSERT INTO SS_Advertisement (advertisementId, advertisementTitle, advertisementDescription, advertisementImage, price, sold, active, new, saleStart, saleEnd, salePrice, stock, idcategory)
VALUES (SS_advertisementId_seq.nextval,'Electric Guitar','Are you into heavy metal music? You found the right instrument for you.',
EMPTY_BLOB(), 200, 'N', 'Y', 'Y', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 189.99, 15, 1006);

INSERT INTO SS_Advertisement (advertisementId, advertisementTitle, advertisementDescription, advertisementImage, price, sold, active, new, saleStart, saleEnd, salePrice, stock, idcategory)
VALUES (SS_advertisementId_seq.nextval,'Sculpture of Prometheus','Sculpture of Prometheus. he gave fire to humans. He was chained and punished for it.',
EMPTY_BLOB(), 10, 'N', 'Y', 'Y', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 8.99, 1, 1001);

-- ################### Shopper ####################
create sequence SS_shopper_seq start with 3001;
--###########Table 3###########
CREATE TABLE SS_Shopper (
	shopperId number,
	FirstName varchar2(15),
	LastName varchar2(20),
	Address varchar2(40),
	City varchar2(20),
	Province char(2),
	Country varchar2(15),
	ZipCode varchar2(15),
	Phone varchar2(10),
	Email varchar2(25),
	UserName varchar2(8),
	Password varchar2(16),
	dtEntered date DEFAULT SYSDATE,
	CONSTRAINT SS_shopper_id_pk PRIMARY KEY(shopperId) );

-- Entry 1
INSERT INTO SS_shopper
    values (SS_shopper_seq.nextval, 'John', 'Doe', '21 Front St.', 'Scarborough',
            'ON', 'Canada','A2H2E2', '9014317701', 'JohnD@aol.com', 'JohnD',
            'Spotsalescool1', '13-JAN-2023');
-- Entry 2
INSERT INTO SS_shopper
    values (SS_shopper_seq.nextval, 'Maria', 'Somner', '287 Walnut Drive', 'Calgary',
            'AB', 'Canada','H3K4B2', '7574216559', 'MarS@infi.net', 'MarS',
            'Mypassword1@', '03-FEB-2023');
-- Entry 3
INSERT INTO SS_shopper 
VALUES (SS_shopper_seq.nextval, 'Michael', 'Smith', '123 Main St.', 'Vancouver',
        'BC', 'Canada', 'V6C3K9', '6049876543', 'm.smith@example.com', 'miksmith',
        'P@ssw0rd123', '15-MAR-2023');

-- Entry 4
INSERT INTO SS_shopper 
VALUES (SS_shopper_seq.nextval, 'Emily', 'Johnson', '456 Oak Ave.', 'Toronto',
        'ON', 'Canada', 'M4B2R7', '4167890123', 'emily.j@example.com', 'emilyj',
        'Qwerty!23', '27-APR-2023');

-- Entry 5
INSERT INTO SS_shopper 
VALUES (SS_shopper_seq.nextval, 'David', 'Lee', '789 Elm St.', 'Montreal',
        'QC', 'Canada', 'H1A3S6', '5142345678', 'davidl@example.com', 'davidlee',
        'Pa$$word456', '10-MAY-2023');

-- Entry 6
INSERT INTO SS_shopper 
VALUES (SS_shopper_seq.nextval, 'Sarah', 'Wilson', '987 Pine Ave.', 'Ottawa',
        'ON', 'Canada', 'K2P1Z8', '6135432198', 's.wilson@example.com', 'sarahw',
        'MySecr3t!', '22-JUN-2023');

-- Entry 7
INSERT INTO SS_shopper 
VALUES (SS_shopper_seq.nextval, 'Andrew', 'Anderson', '111 Cherry St.', 'Edmonton',
        'AB', 'Canada', 'T5J2S4', '7807654321', 'a.anderson@example.com', 'andrewa',
        'Pass123$', '05-JUL-2023');

-- Entry 8
INSERT INTO SS_shopper 
VALUES (SS_shopper_seq.nextval, 'Olivia', 'Brown', '222 Maple Ave.', 'Winnipeg',
        'MB', 'Canada', 'R3B1P7', '2048765432', 'olivia.b@example.com', 'oliviab',
        'P@ssword987', '18-AUG-2023');

-- Entry 9
INSERT INTO SS_shopper 
VALUES (SS_shopper_seq.nextval, 'William', 'Taylor', '333 Birch Rd.', 'Quebec City',
        'QC', 'Canada', 'G1R2V3', '4189876543', 'wtaylor@example.com', 'willt',
        'Taylored1!', '30-SEP-2023');

-- Entry 10
INSERT INTO SS_shopper 
VALUES (SS_shopper_seq.nextval, 'Sophia', 'Martin', '444 Cedar St.', 'Halifax',
        'NS', 'Canada', 'B3J1R7', '9026543210', 's.martin@example.com', 'sophiam',
        'M@rtin567', '12-OCT-2023');

-- ################### Cart ####################
CREATE SEQUENCE SS_CartId_seq start with 4001;
--###########Table 4###########
CREATE TABLE SS_Cart (
	CartId number(5),
	Quantity number(2),
	ShopperId number(4),
	OrderPlaced number(1),
	SubTotal number(7,2),
	Total number(7,2),
	Shipping number(5,2),
	Tax number(6,2),
	dtCreated date DEFAULT SYSDATE,
	Promo number(2),
	ShipFirstName varchar2(10),
	ShipLastName varchar2(20),
	ShipAddress varchar2(40),
	ShipCity varchar2(20),
	ShipState varchar2(2),
	ShipZipCode varchar2(15),
	ShipPhone varchar2(10),
	ShipFax varchar2(10),
	ShipEmail varchar2(25),
	ShipProvince varchar2(20),
	ShipCountry varchar2(20),
	BillFirstName varchar2(10),
	BillLastName varchar2(20),
	BillAddress varchar2(40),
	BillCity varchar2(20),
	BillState varchar2(2),
	BillZipCode varchar2(15),
	BillPhone varchar2(10),
	BillFax varchar2(10),
	BillEmail varchar2(25),
	BillProvince varchar2(20),
	BillCountry varchar2(20),
	dtOrdered date DEFAULT SYSDATE,
	CardType char(1) ,
	CardNumber varchar2(20) ,
	ExpMonth char(2),
        ExpYear char(4),
	CardName varchar2(25),
        shipbill char(1) default 'N',
        ShipFlag char(1) default 'N',
        CONSTRAINT SS_cart_id_pk PRIMARY KEY(CartId),
         CONSTRAINT SS_cart_shopperId_fk FOREIGN KEY (ShopperId)
           REFERENCES SS_Shopper(ShopperId) );

-- Insert 1
INSERT INTO SS_Cart (CartId, Quantity, shopperId, OrderPlaced, SubTotal, Total, Shipping, Tax,
                       ShipFirstName, ShipLastName, ShipAddress, ShipCity, ShipState, ShipZipCode,
                       ShipPhone, ShipEmail, BillFirstName, BillLastName, BillAddress, BillCity,
                       BillState, BillZipCode, BillPhone, BillEmail, CardType, CardNumber, ExpMonth,
                       ExpYear, CardName)
                       
VALUES (SS_CartId_seq.nextval,1,3001,1,100,123.17,9,14.17,
        'John', 'Doe', '21 Front St.', 'Scarborough', 'ON', 'A2H2E2',
        '9014317701', 'JohnD@aol.com', 'John', 'Doe', '21 Front St.', 'Scarborough',
        'ON', 'A2H2E2', '9014317701', 'JohnD@aol.com', 'V', '************1234', '12', '2025', 'John Doe');

-- Insert 2
INSERT INTO SS_Cart (CartId, Quantity, shopperId, OrderPlaced, SubTotal, Total, Shipping, Tax,
                       ShipFirstName, ShipLastName, ShipAddress, ShipCity, ShipState, ShipZipCode,
                       ShipPhone, ShipEmail, BillFirstName, BillLastName, BillAddress, BillCity,
                       BillState, BillZipCode, BillPhone, BillEmail, CardType, CardNumber, ExpMonth,
                       ExpYear, CardName)
VALUES (SS_CartId_seq.nextval,2,3002,1,250,300.58,16,34.58,
        'Maria', 'Somner', '287 Walnut Drive', 'Calgary', 'AB', 'H3K4B2',
        '7574216559', 'MarS@infi.net', 'Maria', 'Somner', '287 Walnut Drive', 'Calgary',
        'AB', 'H3K4B2', '7574216559', 'MarS@infi.net', 'M', '************5678', '09', '2026', 'Maria Somner');

-- Insert 3
INSERT INTO SS_Cart (CartId, Quantity, shopperId, OrderPlaced, SubTotal, Total, Shipping, Tax,
                       ShipFirstName, ShipLastName, ShipAddress, ShipCity, ShipState, ShipZipCode,
                       ShipPhone, ShipEmail, BillFirstName, BillLastName, BillAddress, BillCity,
                       BillState, BillZipCode, BillPhone, BillEmail, CardType, CardNumber, ExpMonth,
                       ExpYear, CardName)
VALUES (SS_CartId_seq.nextval,1,3003,0,100,123.17,9,14.17,
        'Michael', 'Smith', '123 Main St.', 'Vancouver', 'BC', 'V6C3K9',
        '6049876543', 'm.smith@example.com', 'Michael', 'Smith', '123 Main St.', 'Vancouver',
        'BC', 'V6C3K9', '6049876543', 'm.smith@example.com', 'A', '************9876', '06', '2024', 'Michael Smith');

-- Insert 4
INSERT INTO SS_Cart (CartId, Quantity, shopperId, OrderPlaced, SubTotal, Total, Shipping, Tax,
                       ShipFirstName, ShipLastName, ShipAddress, ShipCity, ShipState, ShipZipCode,
                       ShipPhone, ShipEmail, BillFirstName, BillLastName, BillAddress, BillCity,
                       BillState, BillZipCode, BillPhone, BillEmail, CardType, CardNumber, ExpMonth,
                       ExpYear, CardName)
VALUES (SS_CartId_seq.nextval,2,3004,1,120,148.03,11,17.03,
        'Emily', 'Johnson', '456 Oak Ave.', 'Toronto', 'ON', 'M4B2R7',
        '4167890123', 'emily.j@example.com', 'Emily', 'Johnson', '456 Oak Ave.', 'Toronto',
        'ON', 'M4B2R7', '4167890123', 'emily.j@example.com', 'V', '************2345', '11', '2025', 'Emily Johnson');

-- Insert 5
INSERT INTO SS_Cart (CartId, Quantity, shopperId, OrderPlaced, SubTotal, Total, Shipping, Tax,
                       ShipFirstName, ShipLastName, ShipAddress, ShipCity, ShipState, ShipZipCode,
                       ShipPhone, ShipEmail, BillFirstName, BillLastName, BillAddress, BillCity,
                       BillState, BillZipCode, BillPhone, BillEmail, CardType, CardNumber, ExpMonth,
                       ExpYear, CardName)
VALUES (SS_CartId_seq.nextval,1,3005,0,40,51.98,6,5.98,
        'David', 'Lee', '789 Elm St.', 'Montreal', 'QC', 'H1A3S6',
        '5142345678', 'davidl@example.com', 'David', 'Lee', '789 Elm St.', 'Montreal',
        'QC', 'H1A3S6', '5142345678', 'davidl@example.com', 'M', '************4567', '04', '2023', 'David Lee');

-- Insert 6
INSERT INTO SS_Cart (CartId, Quantity, shopperId, OrderPlaced, SubTotal, Total, Shipping, Tax,
                       ShipFirstName, ShipLastName, ShipAddress, ShipCity, ShipState, ShipZipCode,
                       ShipPhone, ShipEmail, BillFirstName, BillLastName, BillAddress, BillCity,
                       BillState, BillZipCode, BillPhone, BillEmail, CardType, CardNumber, ExpMonth,
                       ExpYear, CardName)
VALUES (SS_CartId_seq.nextval,1,3006,1,10000,11333.9,30,1303.9,
        'Sarah', 'Wilson', '987 Pine Ave.', 'Ottawa', 'ON', 'K2P1Z8',
        '6135432198', 's.wilson@example.com', 'Sarah', 'Wilson', '987 Pine Ave.', 'Ottawa',
        'ON', 'K2P1Z8', '6135432198', 's.wilson@example.com', 'A', '************7654', '10', '2023', 'Sarah Wilson');

-- Insert 7
INSERT INTO SS_Cart (CartId, Quantity, shopperId, OrderPlaced, SubTotal, Total, Shipping, Tax,
                       ShipFirstName, ShipLastName, ShipAddress, ShipCity, ShipState, ShipZipCode,
                       ShipPhone, ShipEmail, BillFirstName, BillLastName, BillAddress, BillCity,
                       BillState, BillZipCode, BillPhone, BillEmail, CardType, CardNumber, ExpMonth,
                       ExpYear, CardName)
VALUES (SS_CartId_seq.nextval,1,3007,1,70,89.27,9,10.27,
        'Sophia', 'Martin', '444 Cedar St.', 'Halifax', 'NS', 'B3J1R7',
        '9026543210', 's.martin@example.com', 'Sophia', 'Martin', '444 Cedar St.', 'Halifax',
        'NS', 'B3J1R7', '9026543210', 's.martin@example.com', 'V', '************3210', '02', '2026', 'Sophia Martin');

-- Insert 8
INSERT INTO SS_Cart (CartId, Quantity, shopperId, OrderPlaced, SubTotal, Total, Shipping, Tax,
                       ShipFirstName, ShipLastName, ShipAddress, ShipCity, ShipState, ShipZipCode,
                       ShipPhone, ShipEmail, BillFirstName, BillLastName, BillAddress, BillCity,
                       BillState, BillZipCode, BillPhone, BillEmail, CardType, CardNumber, ExpMonth,
                       ExpYear, CardName)
VALUES (SS_CartId_seq.nextval,1,3008,0,40,51.98,6,5.98,
        'Andrew', 'Anderson', '111 Cherry St.', 'Edmonton', 'AB', 'T5J2S4',
        '7807654321', 'a.anderson@example.com', 'Andrew', 'Anderson', '111 Cherry St.', 'Edmonton',
        'AB', 'T5J2S4', '7807654321', 'a.anderson@example.com', 'M', '************5432', '07', '2023', 'Andrew Anderson');

-- Insert 9
INSERT INTO SS_Cart (CartId, Quantity, shopperId, OrderPlaced, SubTotal, Total, Shipping, Tax,
                       ShipFirstName, ShipLastName, ShipAddress, ShipCity, ShipState, ShipZipCode,
                       ShipPhone, ShipEmail, BillFirstName, BillLastName, BillAddress, BillCity,
                       BillState, BillZipCode, BillPhone, BillEmail, CardType, CardNumber, ExpMonth,
                       ExpYear, CardName)
VALUES (SS_CartId_seq.nextval,1,3009,1,200,240.69,13,27.69,
        'Olivia', 'Brown', '222 Maple Ave.', 'Winnipeg', 'MB', 'R3B1P7',
        '2048765432', 'olivia.b@example.com', 'Olivia', 'Brown', '222 Maple Ave.', 'Winnipeg',
        'MB', 'R3B1P7', '2048765432', 'olivia.b@example.com', 'V', '************8765', '08', '2025', 'Olivia Brown');

-- Insert 10
INSERT INTO SS_Cart (CartId, Quantity, shopperId, OrderPlaced, SubTotal, Total, Shipping, Tax,
                       ShipFirstName, ShipLastName, ShipAddress, ShipCity, ShipState, ShipZipCode,
                       ShipPhone, ShipEmail, BillFirstName, BillLastName, BillAddress, BillCity,
                       BillState, BillZipCode, BillPhone, BillEmail, CardType, CardNumber, ExpMonth,
                       ExpYear, CardName)
VALUES (SS_CartId_seq.nextval,1,3006,0,10,18.08,6,2.08,
        'Sarah', 'Wilson', '987 Pine Ave.', 'Ottawa', 'ON', 'K2P1Z8',
        '6135432198', 's.wilson@example.com', 'Sarah', 'Wilson', '987 Pine Ave.', 'Ottawa',
        'ON', 'K2P1Z8', '6135432198', 's.wilson@example.com', 'A', '************7654', '10', '2023', 'Sarah Wilson');

--########### CartItem ###########
CREATE SEQUENCE SS_CartItemId_seq start with 5001;
--###########Table 5###########
CREATE TABLE SS_CartItem (
	idCartItem number(4),
	CartId number(4),
	AdvertisementId number(4),
	Quantity number(2),
	Price number(7,2),
	CONSTRAINT cartitem_id_pk PRIMARY KEY (idCartItem),
    CONSTRAINT SS_CartItem_CartId_fk FOREIGN KEY (CartId) 
      REFERENCES SS_Cart(CartId),
    CONSTRAINT SS_CartItem_idprod_fk FOREIGN KEY (AdvertisementId) 
      REFERENCES SS_Advertisement(AdvertisementId) );

-- Insert 1
INSERT INTO SS_CartItem (idCartItem, CartId, AdvertisementId, Quantity, Price)
VALUES (SS_CartItemId_seq.NEXTVAL, 4001, 2001, 1, 100);

-- Insert 2
INSERT INTO SS_CartItem (idCartItem, CartId, AdvertisementId, Quantity, Price)
VALUES (SS_CartItemId_seq.NEXTVAL, 4002, 2002, 1, 150);

-- Insert 3
INSERT INTO SS_CartItem (idCartItem, CartId, AdvertisementId, Quantity, Price)
VALUES (SS_CartItemId_seq.NEXTVAL, 4002, 2003, 1, 100);

-- Insert 4
INSERT INTO SS_CartItem (idCartItem, CartId, AdvertisementId, Quantity, Price)
VALUES (SS_CartItemId_seq.NEXTVAL, 4003, 2003, 1, 100);

-- Insert 5
INSERT INTO SS_CartItem (idCartItem, CartId, AdvertisementId, Quantity, Price)
VALUES (SS_CartItemId_seq.NEXTVAL, 4004, 2004, 2, 60);

-- Insert 6
INSERT INTO SS_CartItem (idCartItem, CartId, AdvertisementId, Quantity, Price)
VALUES (SS_CartItemId_seq.NEXTVAL, 4005, 2005, 1, 40);

-- Insert 7
INSERT INTO SS_CartItem (idCartItem, CartId, AdvertisementId, Quantity, Price)
VALUES (SS_CartItemId_seq.NEXTVAL, 4006, 2006, 1, 10000);

-- Insert 8
INSERT INTO SS_CartItem (idCartItem, CartId, AdvertisementId, Quantity, Price)
VALUES (SS_CartItemId_seq.NEXTVAL, 4007, 2007, 1, 70);

-- Insert 9
INSERT INTO SS_CartItem (idCartItem, CartId, AdvertisementId, Quantity, Price)
VALUES (SS_CartItemId_seq.NEXTVAL, 4008, 2008, 1, 40);

-- Insert 10
INSERT INTO SS_CartItem (idCartItem, CartId, AdvertisementId, Quantity, Price)
VALUES (SS_CartItemId_seq.NEXTVAL, 4009, 2009, 1, 200);

-- Insert 11
INSERT INTO SS_CartItem (idCartItem, CartId, AdvertisementId, Quantity, Price)
VALUES (SS_CartItemId_seq.NEXTVAL,4010,2010,1,10);

--########### Shipping ###########
CREATE SEQUENCE SS_RangeId_seq start with 6001;
--###########Table 6###########
CREATE TABLE SS_Shipping (
    RangeId NUMBER(4),
	Low NUMBER(3),
	High NUMBER(3),
	Fee NUMBER(6,2),
	CONSTRAINT SS_ship_idrange_pk PRIMARY KEY (RangeId) ); 

-- Insert 1
INSERT INTO SS_Shipping (RangeId, Low, High, Fee)
VALUES (SS_RangeId_seq.nextval, 0, 50, 6);

-- Insert 2
INSERT INTO SS_Shipping (RangeId, Low, High, Fee)
VALUES (SS_RangeId_seq.nextval, 51, 100, 9);

-- Insert 3
INSERT INTO SS_Shipping (RangeId, Low, High, Fee)
VALUES (SS_RangeId_seq.nextval, 101, 150, 11);

-- Insert 4
INSERT INTO SS_Shipping (RangeId, Low, High, Fee)
VALUES (SS_RangeId_seq.nextval, 151, 200, 13);

-- Insert 5
INSERT INTO SS_Shipping (RangeId, Low, High, Fee)
VALUES (SS_RangeId_seq.nextval, 201, 250, 16);

-- Insert 6
INSERT INTO SS_Shipping (RangeId, Low, High, Fee)
VALUES (SS_RangeId_seq.nextval, 251, 300, 19);

-- Insert 7
INSERT INTO SS_Shipping (RangeId, Low, High, Fee)
VALUES (SS_RangeId_seq.nextval, 301, 350, 22);

-- Insert 8
INSERT INTO SS_Shipping (RangeId, Low, High, Fee)
VALUES (SS_RangeId_seq.nextval, 351, 400, 25);

-- Insert 9
INSERT INTO SS_Shipping (RangeId, Low, High, Fee)
VALUES (SS_RangeId_seq.nextval, 401, 450, 28);

-- Insert 10
INSERT INTO SS_Shipping (RangeId, Low, High, Fee)
VALUES (SS_RangeId_seq.nextval, 451, 500, 30);


--########### CartStatus ###########
CREATE SEQUENCE SS_status_seq start with 7001;
--###########Table 7###########
CREATE TABLE SS_CartStatus (
	StatusId number(5),
	CartId number(5),
	StageId number(1),
	dtStage date,
	Notes varchar2(50),
        shipper varchar2(5),
	ShippingNum varchar2(20),
	CONSTRAINT  SS_CartStatus_pk PRIMARY KEY (StatusId),
        CONSTRAINT SS_CartStatus_CartId_fk FOREIGN KEY (CartId)
          REFERENCES SS_Cart(CartId) );

-- Insert 1
INSERT INTO SS_CartStatus (StatusId, CartId, StageId, dtStage, Notes, shipper, ShippingNum)
VALUES (SS_status_seq.NEXTVAL, 4001, 1, SYSDATE, 'Order placed', 'UPS', 'UPSNY12345');

-- Insert 2
INSERT INTO SS_CartStatus (StatusId, CartId, StageId, dtStage, Notes, shipper, ShippingNum)
VALUES (SS_status_seq.NEXTVAL, 4002, 1, SYSDATE, 'Order placed', 'FedEx', 'FEDEXCA67890');

-- Insert 3
INSERT INTO SS_CartStatus (StatusId, CartId, StageId, dtStage, Notes, shipper, ShippingNum)
VALUES (SS_status_seq.NEXTVAL, 4003, 0, SYSDATE, 'Order not placed', null, null);

-- Insert 4
INSERT INTO SS_CartStatus (StatusId, CartId, StageId, dtStage, Notes, shipper, ShippingNum)
VALUES (SS_status_seq.NEXTVAL, 4004, 1, SYSDATE, 'Order placed', 'USPS', 'USPSUS23456');

-- Insert 5
INSERT INTO SS_CartStatus (StatusId, CartId, StageId, dtStage, Notes, shipper, ShippingNum)
VALUES (SS_status_seq.NEXTVAL, 4005, 0, SYSDATE, 'Order not placed', null, null);

-- Insert 6
INSERT INTO SS_CartStatus (StatusId, CartId, StageId, dtStage, Notes, shipper, ShippingNum)
VALUES (SS_status_seq.NEXTVAL, 4006, 1, SYSDATE, 'Order placed', 'FedEx', 'FEDEXCA01234');

-- Insert 7
INSERT INTO SS_CartStatus (StatusId, CartId, StageId, dtStage, Notes, shipper, ShippingNum)
VALUES (SS_status_seq.NEXTVAL, 4007, 1, SYSDATE, 'Order placed', 'DHL', 'DHLGER56789');

-- Insert 8
INSERT INTO SS_CartStatus (StatusId, CartId, StageId, dtStage, Notes, shipper, ShippingNum)
VALUES (SS_status_seq.NEXTVAL, 4008, 0, SYSDATE, 'Order not placed', null, null);

-- Insert 9
INSERT INTO SS_CartStatus (StatusId, CartId, StageId, dtStage, Notes, shipper, ShippingNum)
VALUES (SS_status_seq.NEXTVAL, 4009, 1, SYSDATE, 'Order placed', 'UPS', 'UPSNY89012');

-- Insert 10
INSERT INTO SS_CartStatus (StatusId, CartId, StageId, dtStage, Notes, shipper, ShippingNum)
VALUES (SS_status_seq.NEXTVAL, 4010, 0, SYSDATE, 'Order not placed', null, null);


--########### CatSales ###########
CREATE SEQUENCE SS_cat_sales_seq start with 8001;
--###########Table 8###########
CREATE TABLE SS_cat_sales (
    CatSalesId NUMBER(6),
     CategoryId NUMBER(6),
     month varchar2(6) DEFAULT 'AUG',
     year varchar2(6) DEFAULT '2023',
     qty number(6),
     total number(10,2),
     CONSTRAINT  SS_cat_sales_pk PRIMARY KEY (CatSalesId),
     CONSTRAINT SS_cat_sales_CategoryId_fk FOREIGN KEY (CategoryId)
          REFERENCES SS_Category(CategoryId) );

-- Insert 1
INSERT INTO SS_cat_sales (CatSalesId, CategoryId, qty, total)
VALUES (SS_cat_sales_seq.NEXTVAL,1001,1,10);

-- Insert 2
INSERT INTO SS_cat_sales (CatSalesId, CategoryId, qty, total)
VALUES (SS_cat_sales_seq.NEXTVAL,1002,1,100);

-- Insert 3
INSERT INTO SS_cat_sales (CatSalesId, CategoryId, qty, total)
VALUES (SS_cat_sales_seq.NEXTVAL,1003,3,350);

-- Insert 4
INSERT INTO SS_cat_sales (CatSalesId, CategoryId, qty, total)
VALUES (SS_cat_sales_seq.NEXTVAL,1004,2,120);

-- Insert 5
INSERT INTO SS_cat_sales (CatSalesId, CategoryId, qty, total)
VALUES (SS_cat_sales_seq.NEXTVAL,1005,1,40);

-- Insert 6
INSERT INTO SS_cat_sales (CatSalesId, CategoryId, qty, total)
VALUES (SS_cat_sales_seq.NEXTVAL,1006,1,200);

-- Insert 7
INSERT INTO SS_cat_sales (CatSalesId, CategoryId, qty, total)
VALUES (SS_cat_sales_seq.NEXTVAL,1008,1,40);

-- Insert 8
INSERT INTO SS_cat_sales (CatSalesId, CategoryId, qty, total)
VALUES (SS_cat_sales_seq.NEXTVAL,1009,1,70);

-- Insert 9
INSERT INTO SS_cat_sales (CatSalesId, CategoryId, qty, total)
VALUES (SS_cat_sales_seq.NEXTVAL,1010,1,10000);

--########### ShopSales ###########
--###########Table 9###########
CREATE TABLE SS_shop_sales (
     ShopperId NUMBER(4),
     total number(6,2),
     CONSTRAINT SS_shop_sales_idShopper_fk FOREIGN KEY (ShopperId)
          REFERENCES SS_Shopper(ShopperId) );

-- Insert 1
INSERT INTO SS_shop_sales (ShopperId, total)
VALUES (3001, 500.00);

-- Insert 2
INSERT INTO SS_shop_sales (ShopperId, total)
VALUES (3002, 300.00);

-- Insert 3
INSERT INTO SS_shop_sales (ShopperId, total)
VALUES (3003, 150.00);

-- Insert 4
INSERT INTO SS_shop_sales (ShopperId, total)
VALUES (3004, 800.00);

-- Insert 5
INSERT INTO SS_shop_sales (ShopperId, total)
VALUES (3005, 600.00);

-- Insert 6
INSERT INTO SS_shop_sales (ShopperId, total)
VALUES (3006, 250.00);

-- Insert 7
INSERT INTO SS_shop_sales (ShopperId, total)
VALUES (3007, 350.00);

-- Insert 8
INSERT INTO SS_shop_sales (ShopperId, total)
VALUES (3008, 180.00);

-- Insert 9
INSERT INTO SS_shop_sales (ShopperId, total)
VALUES (3009, 400.00);

-- Insert 10
INSERT INTO SS_shop_sales (ShopperId, total)
VALUES (3010, 200.00);

--########### AuditLogon ###########
--###########Table 10###########
CREATE TABLE SS_audit_logon
  ( userid VARCHAR2(10),
    logdate DATE );
    
CREATE INDEX shprFrstNme 
ON SS_SHOPPER (UserName);

CREATE INDEX adTitle 
ON SS_ADVERTISEMENT (AdvertisementTitle);