/*1. At least 20 vehicles ‐ include vehicles that are a mixture of similar makes, models 
and years. Vehicles should be allocated to at least three different outlets (one of 
which should be the Hamilton outlet) */


-- Insert Insurer Details
INSERT ALL
	INTO insurer (insurerid, nameofinsurer, address, phone) VALUES (1, 'AA Insurance', '13 Pepega Road, Berhampore, Wellington', '04472432')
	INTO insurer (insurerid, nameofinsurer, address, phone) VALUES (2, 'Tower Insurance', '69 Random Street, Arch Hill, Auckland', '09999999')
	INTO insurer (insurerid, nameofinsurer, address, phone) VALUES (3, 'AMP Insurance', '420 Somwhere Street, Avondale, Christchurch', '03226432')
	INTO insurer (insurerid, nameofinsurer, address, phone) VALUES (4, 'State Insurance', '4 Head Road, Berhampore, Wellington', '04472432')
SELECT 1 FROM DUAL;

-- Insert Vehicle Details
INSERT ALL
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('GKN534', 'Mazda', '626', 2016, 27, 1, 1)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('ALP394', 'Nissan', 'Bluebird', 2014, 23, 2, 3)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('NT6776', 'Toyota', 'Corolla', 2013, 21, 3, 2)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('GLM123', 'Honda', 'Accord', 2012, 31, 2, 1)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('OM1122', 'Mazda', '323', 2014, 24, 4, 2)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('RS3456', 'Mazda', '323', 2014, 24, 2, 3)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('ZHU123', 'Nissan', 'Note', 2012, 22, 1, 1)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('PRH345', 'Honda', 'Accord', 2015, 29, 1, 3)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('SUT143', 'Nissan', 'Bluebird', 2015, 21, 2, 1)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('SALES1', 'BMW', '525', 2016, 75, 3, 2)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('RTX390', 'Nissan', 'Bluebird', 2012, 20, 1, 1)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('BBB999', 'Toyota', 'Corolla', 2010, 25, 4, 1)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('GLX125', 'Honda', 'Accord', 2016, 50, 2, 3)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('ORZ192', 'Mazda', '323', 2013, 23, 3, 2)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('RT3756', 'Mazda', '323', 2018, 28, 1, 1)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('ZXU183', 'Nissan', 'Note', 2012, 22, 4, 1)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('YRZ845', 'Honda', 'Accord', 2013, 30, 2, 3)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('SUT172', 'Nissan', 'Bluebird', 2014, 23, 1, 1)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('GEE126', 'BMW', '525', 2017, 80, 1, 3)
	INTO vehicle (regno, make, model, year, rentalprice, insurerid, outletid) VALUES ('BBR091', 'BMW', '525', 2017, 80, 3, 2)
SELECT 1 FROM DUAL;

/* 2. At least 15 client that have booked vehicles. Ten of these clients should have 
completed the rental process – which means, they have returned the vehicles to a 
location of their choice. The collection outlet and returned outlet should be the same 
for five of the clients. Five clients should be repeat customers i.e. they have made at 
least three bookings each. */

--client ids 22122 - 22141
--repeat client 22122, 22125, 22127, 22131, 22135

INSERT ALL
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('GKN534', 22141, '10-Jan-21', '15-Jan-21', '20-Jan-21')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('GKN534', 22122, '10-Feb-15', '11-Feb-15', '17-Feb-15')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('GKN534', 22122, '1-Nov-17', '5-Nov-17', '15-Nov-17')
	INTO booking (regno, clientid, bookingdate, collectiondate) VALUES ('GKN534', 22122, '1-July-21', '1-Aug-21')
	INTO booking (regno, clientid, bookingdate, collectiondate) VALUES ('ALP394', 22123, '21-Jun-21', '12-Aug-21')
	INTO booking (regno, clientid, bookingdate, collectiondate) VALUES ('NT6776', 22124, '30-Jul-21', '29-Sep-21') 
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('GLM123', 22125, '12-Dec-16', '15-Dec-16', '1-Jan-17')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('OM1122', 22125, '10-Jan-18', '11-Jan-18', '15-Jan-18')
	INTO booking (regno, clientid, bookingdate) VALUES ('OM1122', 22125, '10-Jan-21')
	INTO booking (regno, clientid, bookingdate) VALUES ('OM1122', 22125, '10-Jan-21')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('RS3456', 22126, '10-Jan-15', '11-Jan-15', '13-Jan-15')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('ZHU123', 22127, '1-Feb-15', '10-Feb-15', '19-Feb-15')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('ZHU123', 22127, '7-Jan-16', '10-Jan-16', '15-Jan-16')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('PRH345', 22127, '3-Mar-18', '7-Jan-18', '17-Jan-18')
	INTO booking (regno, clientid, bookingdate) VALUES ('SUT143', 22128, '10-Aug-21')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('SUT143', 22129, '10-Jan-20', '11-Jan-20', '20-Jan-20')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('SALES1', 22130, '10-Oct-15', '20-Oct-15', '1-Nov-15')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('SALES1', 22131, '1-Feb-20', '20-Feb-20', '25-Feb-20')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('SALES1', 22131, '10-Aug-20', '15-Nov-20', '21-Nov-20')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('RTX390', 22131, '10-Dec-20', '1-Jan-21', '13-Jan-21')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('GLX125', 22132, '1-Jan-16', '5-Jan-16', '11-Jan-16')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('BBB999', 22133, '2-Jan-17', '5-Jan-17', '12-Jan-17')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('ORZ192', 22134, '4-Jan-15', '6-Jan-15', '15-Jan-15')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('ORZ192', 22135, '2-Jan-18', '9-Jan-18', '13-Jan-18')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('RT3756', 22135, '11-Mar-19', '15-Mar-19', '25-Mar-19')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('ZXU183', 22135, '10-Oct-20', '20-Jan-20', '21-Jan-20')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('ZXU183', 22136, '10-Jan-16', '12-Jan-16', '14-Jan-16')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('ZXU183', 22137, '1-May-15', '10-May-15', '13-Jan-15')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('YRZ845', 22138, '1-Jul-18', '15-Jul-18', '28-Jul-18')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('SUT172', 22139, '10-Jun-19', '13-Jun-19', '20-Jun-19')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('GEE126', 22140, '10-Jan-16', '15-Jan-16', '20-Jan-16')
	INTO booking (regno, clientid, bookingdate, collectiondate, returndate) VALUES ('BBR091', 22141, '10-Jan-15', '15-Jan-15', '20-Jan-15')
SELECT 1 FROM DUAL;

--review after michael email
--insert rental price from vehicle to booking
UPDATE booking SET (booking.rentalprice) = 
(
SELECT vehicle.rentalprice FROM vehicle
WHERE booking.regno = vehicle.regno
);

/*3. 5 agents of which 2 are managers (Rob and John) and one of the managers is supervising 2agents. */
INSERT ALL	
	INTO agent (agentid, outletid, fname, lname, phone, commissionrate, managerid) VALUES ('001', 1, 'Rob', 'Smith', '02107777777', 20.00, '001')
	INTO agent (agentid, outletid, fname, lname, phone, commissionrate, managerid) VALUES ('002', 2, 'John', 'Mclain', '02107557777', 20.00, '002')
	INTO agent (agentid, outletid, fname, lname, phone, commissionrate, managerid) VALUES ('003', 1, 'Bob', 'Mclain', '02107557777', 15.00, '001')
	INTO agent (agentid, outletid, fname, lname, phone, commissionrate, managerid) VALUES ('004', 2, 'Bill', 'Mclain', '02107557777', 15.00, '002')
	INTO agent (agentid, outletid, fname, lname, phone, commissionrate, managerid) VALUES ('005', 3, 'Jess', 'Mclain', '02107557777', 15.00,  '001')
SELECT 1 FROM DUAL;
	
--insert rental details
INSERT ALL 
	INTO rental (agentidcollection, bookingid, startdate, enddate, agentidreturn) VALUES ('001', 50000000, '15-Jan-21', '20-Jan-21', '001')
	INTO rental (agentidcollection, bookingid, startdate, enddate, agentidreturn) VALUES ('002', 50000001, '11-Feb-15', '17-Feb-15', '002')
	INTO rental (agentidcollection, bookingid, startdate, enddate, agentidreturn) VALUES ('005', 50000002, '5-Nov-17', '15-Nov-17', '002')
	INTO rental (agentidcollection, bookingid, startdate, enddate, agentidreturn) VALUES ('003', 50000003, '1-Aug-21', '10-Aug-21', '001')
	INTO rental (agentidcollection, bookingid, startdate, enddate, agentidreturn) VALUES ('005', 50000004, '12-Aug-21', '19-Aug-21', '005')
	INTO rental (agentidcollection, bookingid, startdate, enddate, agentidreturn) VALUES ('003', 50000005, '29-Sep-21', '10-Oct-21', '004')
	INTO rental (agentidcollection, bookingid, startdate, enddate, agentidreturn) VALUES ('002', 50000006, '15-Dec-16', '1-Jan-17', '001')
	INTO rental (agentidcollection, bookingid, startdate, enddate, agentidreturn) VALUES ('004', 50000007, '11-Jan-18', '13-Jan-18', '004')
	INTO rental (agentidcollection, bookingid, startdate, enddate, agentidreturn) VALUES ('001', 50000010, '10-Jan-15', '19-Feb-15', '001')
	INTO rental (agentidcollection, bookingid, startdate, enddate, agentidreturn) VALUES ('004', 50000011, '10-Jan-16', '15-Jan-16', '001')
SELECT 1 FROM DUAL;

--insert payments 
--10 payments of which 3 of those payments have been made by the same client more than once for the same rental
--3 clients should have made additional payment for fuel charges
--3 clients should have made additional payments for vehicles returned in an undesirable state ??? (does this mean surcharge)
INSERT ALL 
	INTO payment (rentalno, paymenttypeid) VALUES (80000000, 2) 
	INTO payment (rentalno, paymenttypeid) VALUES (80000000, 3) 
	INTO payment (rentalno, paymenttypeid, amount) VALUES (80000000, 4, 50) 
	INTO payment (rentalno, paymenttypeid, amount) VALUES (80000001, 1, 50) 
	INTO payment (rentalno, paymenttypeid, amount) VALUES (80000001, 5, 100) 
	INTO payment (rentalno, paymenttypeid, amount) VALUES (80000002, 4, 50) 
	INTO payment (rentalno, paymenttypeid, amount) VALUES (80000003, 2, 50) 
	INTO payment (rentalno, paymenttypeid, amount) VALUES (80000004, 2, 50)  
	INTO payment (rentalno, paymenttypeid, amount) VALUES (80000005, 2, 50) 
	INTO payment (rentalno, paymenttypeid) VALUES (80000006, 1) 
	INTO payment (rentalno, paymenttypeid) VALUES (80000008, 4) 
	INTO payment (rentalno, paymenttypeid) VALUES (80000007, 1) 
	INTO payment (rentalno, paymenttypeid, amount) VALUES (80000008, 5, 200)
	INTO payment (rentalno, paymenttypeid, amount) VALUES (80000007, 5, 500)
SELECT 1 FROM DUAL;

UPDATE payment SET (payment.amount) = 
(
SELECT (rental.enddate - rental.startdate + 1) * booking.rentalprice
FROM rental, booking
WHERE rental.rentalno = payment.rentalno AND rental.bookingid = booking.bookingid AND payment.paymenttypeid = 1
)
WHERE payment.paymenttypeid = 1;

UPDATE payment SET (payment.amount) = 
(
SELECT ((rental.enddate - rental.startdate + 1) * booking.rentalprice)*0.30
FROM rental, booking
WHERE rental.rentalno = payment.rentalno AND rental.bookingid = booking.bookingid AND payment.paymenttypeid = 2
)
WHERE payment.paymenttypeid = 2;

UPDATE payment SET (payment.amount) = 
(
SELECT ((rental.enddate - rental.startdate + 1) * booking.rentalprice) - 
	(
	SELECT payment.amount 
	FROM payment 
	WHERE rentalno = 80000000 AND paymenttypeid = 2
	)
FROM rental, booking
WHERE rental.rentalno = payment.rentalno AND rental.bookingid = booking.bookingid AND payment.paymenttypeid = 3
)
WHERE payment.paymenttypeid = 3;

--continue here

UPDATE payment SET (payment.clientid) = 
(
SELECT booking.clientid 
FROM booking, rental
WHERE booking.bookingid = rental.bookingid AND rental.rentalno = payment.rentalno
);	

UPDATE payment SET (paydate) =
(
SELECT booking.bookingdate 
FROM booking, rental
WHERE booking.bookingid = rental.bookingid AND rental.rentalno = payment.rentalno AND payment.paymenttypeid IN (1, 2)
)
WHERE payment.paymenttypeid IN (1, 2);

UPDATE payment set (paydate) =
(
SELECT booking.returndate
FROM booking, rental
WHERE booking.bookingid = rental.bookingid AND rental.rentalno = payment.rentalno AND payment.paymenttypeid IN (4, 5)
)
WHERE payment.paymenttypeid IN (4, 5);

UPDATE payment SET (paydate) =
(
SELECT booking.collectiondate
FROM booking, rental
WHERE booking.bookingid = rental.bookingid AND rental.rentalno = payment.rentalno AND payment.paymenttypeid = 3
)
WHERE payment.paymenttypeid = 3;

UPDATE rental SET (rental.returndate) =
(
SELECT booking.returndate
FROM booking
WHERE booking.bookingid = rental.bookingid
);

INSERT INTO invoice (bookingid, invoicedate, rentalprice, totalamt) VALUES(50000000, 
(SELECT booking.returndate FROM booking WHERE booking.bookingid = 50000000), 
(SELECT booking.rentalprice FROM booking WHERE booking.bookingid = 50000000),
(SELECT SUM(payment.amount) FROM payment, booking, rental WHERE booking.bookingid = 50000000 AND booking.bookingid = rental.bookingid AND rental.rentalno = payment.rentalno));

COMMIT;
