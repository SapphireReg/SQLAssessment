--Delete all Tables
DROP TABLE INVOICE CASCADE CONSTRAINT;
DROP TABLE CANCEL CASCADE CONSTRAINT;
DROP TABLE PAYMENT CASCADE CONSTRAINT;
DROP TABLE RENTAL CASCADE CONSTRAINT;
DROP TABLE BOOKING CASCADE CONSTRAINT;
DROP TABLE PAYMENTTYPE CASCADE CONSTRAINT;
DROP TABLE VEHICLE CASCADE CONSTRAINT;
DROP TABLE INSURER CASCADE CONSTRAINT;
DROP TABLE AGENT CASCADE CONSTRAINT;
DROP TABLE CLIENT CASCADE CONSTRAINT;
DROP TABLE OUTLET CASCADE CONSTRAINT;

--Delete all Sequences
DROP SEQUENCE bookseq;
DROP SEQUENCE rentalseq;
DROP SEQUENCE paymentseq;
DROP SEQUENCE cancelseq;
DROP SEQUENCE invoiceseq;

--create table Outlet

 CREATE TABLE OUTLET 
 (	
	OUTLETID NUMBER PRIMARY KEY, 
	STREETADDRESS VARCHAR2(50), 
	SUBURB VARCHAR2(50) NOT NULL, 
	CITY VARCHAR2(50), 
	PHONE VARCHAR2(20) 
 ); 

-- create table ClientID
 
 CREATE TABLE CLIENT 
   (	 
	CLIENTID VARCHAR2(10) PRIMARY KEY,
	FNAME VARCHAR2(50) NOT NULL,
	LNAME VARCHAR2(50) NOT NULL, 
	GENDER CHAR(1),
	ADDRESS1 VARCHAR2(50) NOT NULL, 
	ADDRESS2 VARCHAR2(50) NOT NULL, 
	ADDRESS3 VARCHAR2(50) NOT NULL, 
	PHONE VARCHAR2(12)
   );
 
  --create table Agent
 
  CREATE TABLE AGENT 
   (
    AGENTID VARCHAR2(10) PRIMARY KEY, 
	OUTLETID NUMBER, 
	FNAME VARCHAR2(50) NOT NULL, 
	LNAME VARCHAR2(50), 
	PHONE VARCHAR2(12), 
	COMMISSIONRATE NUMBER(6,3), 
	MANAGERID VARCHAR2(10),	 
	CONSTRAINT AGT_FK FOREIGN KEY (OUTLETID)  REFERENCES OUTLET(OUTLETID), 
	CONSTRAINT MGT_FK FOREIGN KEY (MANAGERID) REFERENCES AGENT(AGENTID)
   ) ;

   
 --create table Insurer
 CREATE TABLE INSURER 
   (	
    	INSURERID NUMBER PRIMARY KEY, 
	NAMEOFINSURER VARCHAR2(50), 
	ADDRESS VARCHAR2(50), 
	PHONE VARCHAR2(12)  
   ) ;
 
 --create table Vehicle
 
  CREATE TABLE VEHICLE
   (
    	REGNO VARCHAR2(10) PRIMARY KEY, 
	MAKE VARCHAR2(20), 
	MODEL VARCHAR2(20), 
	YEAR NUMBER(5), 
	RENTALPRICE NUMBER(7,2), 
	INSURERID NUMBER(1), 
	OUTLETID NUMBER(1), 	 
	CONSTRAINT VH_FK FOREIGN KEY (INSURERID) REFERENCES INSURER(INSURERID), 
	CONSTRAINT VOUT_FK FOREIGN KEY(OUTLETID) REFERENCES OUTLET(OUTLETID)
   ) ;

   --create table paymenttype
   
  CREATE TABLE PAYMENTTYPE
   (
    	PAYMENTTYPEID NUMBER(1) PRIMARY KEY, 
    	DESCRIPTION VARCHAR2(50) 
   );
   
   --create booking table
    CREATE TABLE BOOKING(	
	BOOKINGID NUMBER PRIMARY KEY, 
	REGNO VARCHAR2(10), 
	CLIENTID VARCHAR2(10), 
	BOOKINGDATE DATE, 
	COLLECTIONDATE DATE, 
	RETURNDATE DATE, 
	RENTALPRICE NUMBER(7,2), 
	CONSTRAINT REGNN_FK FOREIGN KEY (REGNO) REFERENCES VEHICLE(REGNO), 
	CONSTRAINT CLBN_FK FOREIGN KEY (CLIENTID) REFERENCES CLIENT(CLIENTID)
   );

   CREATE SEQUENCE bookseq
   START WITH 50000000
   INCREMENT BY 1;


CREATE OR REPLACE TRIGGER bookseq_trg
BEFORE INSERT ON Booking
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT bookseq.NEXTVAL INTO :NEW.BookingID FROM DUAL;
END;
/

--create table rental

    CREATE TABLE RENTAL(	
	RENTALNO NUMBER PRIMARY KEY,
	BOOKINGID NUMBER,
	AGENTIDCOLLECTION VARCHAR2(10),
	AGENTIDRETURN VARCHAR2(10),
	STARTDATE DATE, 
	ENDDATE DATE,
	RETURNDATE DATE,	
	CONSTRAINT RENT_FK FOREIGN KEY (BOOKINGID) REFERENCES BOOKING(BOOKINGID), 
	CONSTRAINT AGTC_FK FOREIGN KEY (AGENTIDCOLLECTION) REFERENCES AGENT(AGENTID)
   );
   
   --create rental sequence number and trigger

CREATE SEQUENCE rentalseq
START WITH 80000000
INCREMENT BY 1;


CREATE OR REPLACE TRIGGER rentalseq_trg
BEFORE INSERT ON Rental
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT rentalseq.NEXTVAL INTO :NEW.RentalNo FROM DUAL;
END;
/


--create table payment

 CREATE TABLE PAYMENT(	
	PAYMENTID NUMBER PRIMARY KEY, 
	CLIENTID VARCHAR2(10), 
	PAYMENTTYPEID NUMBER(1), 
	RENTALNO NUMBER, 
	PAYDATE DATE,
	AMOUNT NUMBER(7,2),
	CONSTRAINT CLK_FK FOREIGN KEY (CLIENTID) REFERENCES CLIENT(CLIENTID), 
	CONSTRAINT PMTY_FK FOREIGN KEY (PAYMENTTYPEID) REFERENCES PAYMENTTYPE(PAYMENTTYPEID),
	CONSTRAINT RENTA_FK FOREIGN KEY (RENTALNO) REFERENCES RENTAL(RENTALNO) --Mistake 
   );

CREATE SEQUENCE paymentseq
START WITH 20000000
INCREMENT BY 1;


CREATE OR REPLACE TRIGGER paymentseq_trg
BEFORE INSERT ON Payment
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT paymentseq.NEXTVAL INTO :NEW.PaymentID FROM DUAL;
END;
/

--CREATE CANCEL TABLE
 CREATE TABLE CANCEL(	
	CANCELID NUMBER PRIMARY KEY, 
	BOOKINGID NUMBER, 
	CANCELDATE DATE, 
	REFUNDAMT NUMBER(7,2),	
	CONSTRAINT CBKB_FK FOREIGN KEY (BOOKINGID) REFERENCES BOOKING(BOOKINGID)
   );

CREATE SEQUENCE cancelseq
START WITH 90000000
INCREMENT BY 1;


CREATE OR REPLACE TRIGGER cancelseq_trg
BEFORE INSERT ON Cancel
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT cancelseq.NEXTVAL INTO :NEW.CancelID FROM DUAL;
END;
/

--CREATE INVOICE TABLE
 CREATE TABLE INVOICE(	
	INVOICENO NUMBER PRIMARY KEY, 
	BOOKINGID NUMBER, 
	INVOICEDATE DATE, 
	RENTALPRICE NUMBER(7,2),--Mistake comma was missing
	TOTALAMT NUMBER(7,2),	
	CONSTRAINT INVBK_FK FOREIGN KEY (BOOKINGID) REFERENCES BOOKING(BOOKINGID)
	);
 
--create Invoice sequence number and trigger

CREATE SEQUENCE invoiceseq
START WITH 100000
INCREMENT BY 1;


CREATE OR REPLACE TRIGGER invoiceseq_trg
BEFORE INSERT ON Invoice
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
	SELECT invoiceseq.NEXTVAL INTO :NEW.InvoiceNo FROM DUAL;
END;
/

--Insert data for three outlets

INSERT INTO OUTLET(OutletID,StreetAddress,Suburb,City,Phone)VALUES(1,'14 Te Atatu Road','Te Atatu South','Auckland','098548789');
INSERT INTO OUTLET(OutletID,StreetAddress,Suburb,City,Phone)VALUES(2,'24 Tristram Street','City','Hamilton','078648789');
INSERT INTO OUTLET(OutletID,StreetAddress,Suburb,City,Phone)VALUES(3,'40 MacNee Street','Mornington','Dunedin','034548722');

--insert client data
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22122,'Jordan','Hammond','M','23 Clive Road','Fairfied','Hamilton','021450089');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22123,'Peter','Grant','M','13 Mansel Ave','Hillcrest','Hamilton','078555113');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22124,'Gabriel','Ashley','M','52 Masters Ave','Hillcrest','Hamilton','078531162');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22125,'Alex','Grant','M','18 Thomas Road','Huntington','Hamilton','078548112');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22126,'Michael','Jordan','M','65 Campbell Street','Frankton','Hamilton','0221066343');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22127,'Charles','Hammond','M','32 Newcastle Road','Dinsdale','Hamilton','022098555');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22128,'Matthew','Forson','M','519 Maitai Valley Road','Maitai','Nelson','021450012');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22129,'John','Quayson','M','16 Breaker Bay','Breaker Bay','Wellington','027266521');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22130,'Luke','Harris','M','87 Yvonne Road','Melville','Hamilton','027140761');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22131,'William','McArthur','M','5 Pollard Street','Lower Hutt','Wellington','02106572');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22132,'Harry','McConnell','M','86 Grandview Road','Nawton','Hamilton','022884432');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22133,'Diana','Hart','F','29 Hine Road','Lower Hutt','Wellington','027087651');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22134,'Margarette','Ford','F','203 Grey Street','Hamilton East','Hamilton','078989811');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22135,'Charlotte','Bennett','F','22 Sunset Road','North Shore','Auckland','090098751');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22136,'Noviet','Strange','F','12 Bryant Road','St Andrews','Hamilton','0228856402');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22137,'Marian','Williams','F','8 MacNee Street','Mornington','Dunedin','021145087');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22138,'Felix','Thomas','M','8 Lincoln Road','Henderson','Auckland','021057868');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22139,'Isaac','Brown','M','534 Te Rapa Road','Te Rapa','Hamilton','022228761');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22140,'Ivy','Briant','F','43 Woodside Road','Mount Eden','Auckland','027785611');
INSERT INTO CLIENT(ClientID,FName,LName,Gender,Address1,Address2,Address3,Phone)VALUES(22141,'Felicia','Grant','M','110 Sandwich Road','St Andrews','Hamilton','022568889');

--insert data into paymenttype table
INSERT INTO PAYMENTTYPE (PaymentTypeID,Description)VALUES(1,'FULL');
INSERT INTO PAYMENTTYPE (PaymentTypeID,Description)VALUES(2,'DEPOSIT');
INSERT INTO PAYMENTTYPE (PaymentTypeID,Description)VALUES(3,'Additional Payment');
INSERT INTO PAYMENTTYPE (PaymentTypeID,Description)VALUES(4,'FUEL SURCHARGE');
INSERT INTO PAYMENTTYPE (PaymentTypeID,Description)VALUES(5,'Other SURCHARGE');

COMMIT;