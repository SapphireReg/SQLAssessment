-- CURSORS (create reports using CSV formatting)
-- 1. Displays all clients that have booked a vehicle. Inc client name, bookingID, vehicle reg, rental price, make and model
SET SERVEROUTPUT ON;
SPOOL 'C:\Reports\BookedClient.csv';

DECLARE
    CURSOR client_book_cursor IS
        SELECT c.fname, c.lname, b.bookingid, b.regno, b.rentalprice, v.make, v.model
		FROM client c, booking b, vehicle v 
		WHERE c.clientid = b.clientid AND v.regno = b.regno;
	client_row		client_book_cursor%ROWTYPE;
	rec_output		VARCHAR2(200);
BEGIN
	DBMS_OUTPUT.PUT_LINE('C_FNAME,'||'C_LNAME,'||'BOOKINGID,'||'REGNO,'||'RENTALPRICE,'||'V_MAKE.'||'V_MODEL');
    FOR client_row IN client_book_cursor LOOP
            rec_output :=   client_row.fname || ',' ||
                            client_row.lname || ',' ||
                            client_row.bookingid || ',' ||
                            client_row.regno || ',$' ||
                            client_row.rentalprice || ',' ||
                            client_row.make || ',' ||
                            client_row.model;
			DBMS_OUTPUT.PUT_LINE(rec_output);
    END LOOP;
END;
/
SPOOL OFF;

-- 2. Display all rentals that have not been returned. Incl client name, rental num, vehicle reg, & startdate
SET SERVEROUTPUT ON;
SPOOL 'C:\Reports\NotReturnedVehicles.csv';

DECLARE
    CURSOR not_returned_cursor IS
        SELECT b.regno, c.fname, c.lname, r.rentalno, r.startdate
		FROM booking b, client c, rental r
		WHERE c.clientid = b.clientid AND b.bookingid = r.bookingid AND r.startdate IS NOT NULL AND r.returndate IS NULL;
	vehicle_row		not_returned_cursor%ROWTYPE;
	rec_output		VARCHAR2(200);
BEGIN
	DBMS_OUTPUT.PUT_LINE('BOOKING_ID,'||'C_FNAME,'||'C_LNAME,'||'REG_NO,'||'START_DATE');
    FOR vehicle_row IN not_returned_cursor LOOP
            rec_output :=   vehicle_row.regno || ',' ||
							vehicle_row.fname || ',' ||
                            vehicle_row.lname || ',' ||
                            vehicle_row.rentalno || ',' ||
                            vehicle_row.startdate;
			DBMS_OUTPUT.PUT_LINE(rec_output);
    END LOOP;
END;
/
SPOOL OFF;


-- PROCEDURES (with CSV output and input request for user parameter input into producedure
-- 3. Vehicles are available for rental and the manager would like to find vehicles by make. The producedure name is RentalByMake(). Create and test with 'Honda'
CREATE OR REPLACE PROCEDURE RentalByMake(
	vehicleMake IN CHAR
)
IS
	CURSOR makeCursor IS
		SELECT *
		FROM vehicle 
		WHERE make = vehicleMake;
	vehicle_row			makeCursor%ROWTYPE;
	rec_output			VARCHAR(200);
BEGIN
	DBMS_OUTPUT.PUT_LINE('REG_NO,'||'MAKE,'||'MODEL,'||'YEAR,'||'RENTALPRICE,'||'INSURERID,'||'OUTLETID');
	FOR vehicle_row IN makeCursor LOOP
		rec_output := vehicle_row.regno || ',' ||
					  vehicle_row.make || ',' ||
					  vehicle_row.model || ',' ||
					  vehicle_row.year || ',' ||
					  vehicle_row.rentalprice || ',' ||
					  vehicle_row.insurerid || ',' ||
					  vehicle_row.outletid;
			DBMS_OUTPUT.PUT_LINE(rec_output);
	END LOOP;
EXCEPTION 
	WHEN OTHERS THEN 
			ROLLBACK;
END;
/
SET SERVEROUTPUT ON;
SPOOL 'C:\Reports\vehicleMake.csv';
ACCEPT search_vehicle_make PROMPT'Enter Vehicle Make:';
EXECUTE RentalByMake('&search_vehicle_make');
SPOOL OFF;


-- 4. The manger would like to find rental vehicles by model. Procedure name is RentalByModel(). Create and test with 'Jazz'.
CREATE OR REPLACE PROCEDURE RentalByModel(
	vehicleModel IN CHAR
)
IS
	CURSOR modelCursor IS
		SELECT *
		FROM vehicle 
		WHERE model = vehicleModel;
	vehicle_row			modelCursor%ROWTYPE;
	rec_output			VARCHAR(200);
BEGIN
	DBMS_OUTPUT.PUT_LINE('REG_NO,'||'MAKE,'||'MODEL,'||'YEAR,'||'RENTALPRICE,'||'INSURERID,'||'OUTLETID');
	FOR vehicle_row IN modelCursor LOOP
		rec_output := vehicle_row.regno || ',' ||
					  vehicle_row.make || ',' ||
					  vehicle_row.model || ',' ||
					  vehicle_row.year || ',' ||
					  vehicle_row.rentalprice || ',' ||
					  vehicle_row.insurerid || ',' ||
					  vehicle_row.outletid;
			DBMS_OUTPUT.PUT_LINE(rec_output);
	END LOOP;
EXCEPTION 
	WHEN OTHERS THEN 
			ROLLBACK;
END;
/
SET SERVEROUTPUT ON;
SPOOL 'C:\Reports\vehicleModel.csv';
ACCEPT search_vehicle_model PROMPT 'Enter Vehicle Model:';
EXECUTE RentalByModel('&search_vehicle_model');
SPOOL OFF;

-- 5. Create TWO separate procedures for searching clients details by a specific id and last name. Inc details of the client inc the total payment, and the vehicle details. 
-- Test with ClientID 22122 and LastN 'Ashley'
CREATE OR REPLACE PROCEDURE SearchByClientLname(
	ClientLname IN CHAR
)
IS
	CURSOR clnameCursor IS
		SELECT c.clientid, c.lname, c.fname, c.gender, c.address1, c.address2, c.address3, c.phone, p.amount, v.regno, v.make, v.model, v.year 
		FROM payment p, client c, booking b, vehicle v
		WHERE c.clientid = p.clientid AND c.clientid = b.clientid AND v.regno = b.regno AND c.lname = ClientLname;
	client_row			clnameCursor%ROWTYPE;
	rec_output			VARCHAR(200);
BEGIN
	DBMS_OUTPUT.PUT_LINE('C_ID,'||'C_LNAME,'||'C_FNAME,'||'GENDER,'||'STREET_ADD,'||'SUBURB,'||'CITY,'||'PAYMENT_AMOUNT,'||'REGNO,'||'MAKE,'||'MODEL,'||'YEAR');
	FOR client_row IN clnameCursor LOOP
		rec_output := client_row.clientid || ',' ||
					  client_row.lname || ',' ||
					  client_row.fname || ',' ||
					  client_row.gender || ',' ||
					  client_row.address1 || ',' ||
					  client_row.address2 || ',' ||
					  client_row.address3 || ',' ||
					  client_row.regno || ',' ||
					  client_row.make || ',' ||
					  client_row.model || ',' ||
					  client_row.year;
			DBMS_OUTPUT.PUT_LINE(rec_output);
	END LOOP;
EXCEPTION 
	WHEN OTHERS THEN 
			ROLLBACK;
END;
/
SET SERVEROUTPUT ON;
SPOOL 'C:\Reports\SearchClientByLname.csv';
ACCEPT clientLname PROMPT 'ENTER Client Name:';
EXECUTE SearchByClientLname('&clientLname');
SPOOL OFF;


--search by client ID
CREATE OR REPLACE PROCEDURE SearchByClientID(
	in_client_id IN client.clientID%TYPE
)
IS
	CURSOR cidCursor IS
		SELECT c.clientid, c.lname, c.fname, c.gender, c.address1, c.address2, c.address3, c.phone, p.amount, v.regno, v.make, v.model, v.year 
		FROM payment p, client c, booking b, vehicle v
		WHERE c.clientid = p.clientid AND c.clientid = b.clientid AND v.regno = b.regno AND c.clientid = in_client_id;
	client_row			cidCursor%ROWTYPE;
	rec_output			VARCHAR(200); 	
BEGIN
	DBMS_OUTPUT.PUT_LINE('C_ID,'||'C_LNAME,'||'C_FNAME,'||'GENDER,'||'STREET_ADD,'||'SUBURB,'||'CITY,'||'PAYMENT_AMOUNT,'||'REGNO,'||'MAKE,'||'MODEL,'||'YEAR');
	FOR client_row IN cidCursor LOOP
		rec_output := client_row.clientid || ',' ||
					  client_row.lname || ',' ||
					  client_row.fname || ',' ||
					  client_row.gender || ',' ||
					  client_row.address1 || ',' ||
					  client_row.address2 || ',' ||
					  client_row.address3 || ',' ||
					  client_row.regno || ',' ||
					  client_row.make || ',' ||
					  client_row.model || ',' ||
					  client_row.year;
			DBMS_OUTPUT.PUT_LINE(rec_output);
	END LOOP;
EXCEPTION 
	WHEN OTHERS THEN 
			ROLLBACK;
END;
/
SET SERVEROUTPUT ON;
SPOOL 'C:\Reports\SearchClientByID.csv';
ACCEPT in_client_id PROMPT 'ENTER Client Name:';
EXECUTE SearchByClientID('&in_client_id');
SPOOL OFF;


-- 6. Performates booking report for a given time period. Inc clients, booking, and vehicle details. Procedure name is BookingReport(). Test with year 2017 and from Jan to June.
CREATE OR REPLACE PROCEDURE BookingReport(
in_date_start IN booking.bookingdate%TYPE,
in_date_end IN booking.bookingdate%TYPE
)
IS
	CURSOR bookReportCursor IS
		SELECT c.clientid, c.lname, c.fname, b.bookingid, b.bookingdate, b.collectiondate, v.regno, v.make, v.model, v.rentalprice
		FROM client c, booking b, vehicle v
		WHERE c.clientid = b.clientid  AND b.regno = v.regno AND b.bookingdate BETWEEN in_date_start AND in_date_end;
	booking_row			bookReportCursor%ROWTYPE;
	rec_output			VARCHAR(200);
BEGIN 
	DBMS_OUTPUT.PUT_LINE('C_ID,'||'C_LNAME,'||'C_FNAME,'||'BOOKING_NUM,'||'BOOKING_DATE,'||'COLLECTION_DATE,'||'REG_NO,'||'MAKE,'||'MODEL,'||'RENTALPRICE');
	FOR booking_row IN bookReportCursor LOOP 
		rec_output := booking_row.clientid || ',' ||
					  booking_row.lname || ',' || 
					  booking_row.fname || ',' ||
					  booking_row.bookingid || ',' || 
					  booking_row.bookingdate || ',' ||
					  booking_row.collectiondate || ',' ||
					  booking_row.regno || ',' ||
					  booking_row.make || ',' ||
					  booking_row.model || ',' ||
					  booking_row.rentalprice;
		DBMS_OUTPUT.PUT_LINE(rec_output);
	END LOOP;
EXCEPTION
	WHEN OTHERS THEN
			ROLLBACK;
END;
/
SET SERVEROUTPUT ON;
SPOOL 'C:\Reports\SearchBookingByDate.csv';
ACCEPT in_date_start PROMPT 'Enter Start Date';
ACCEPT in_date_end PROMPT 'Enter End Date';
EXECUTE BookingReport('&in_date_start', '&in_date_end')
SPOOL OFF;

-- FUNCTION with a procedure report
-- 7. Create a function NumberOfDays() that calculates the number of days between two dates. Accepts start and end date as parameters, then returns how many days
CREATE OR REPLACE FUNCTION calculate_days (
	in_date_start IN DATE, 
	in_date_end IN DATE 
) RETURN number 
IS
	daysDif NUMBER;
BEGIN 
	daysDif := in_date_end - in_date_start;
	RETURN daysDif;
EXCEPTION
	WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

-- 8. Create CSV procedure that determines the number of days of a rental. Inc the rental number, agentID (agent who rented vehicle), total payment for the rental, and number of days.
-- Use NumberOfDays() function to calculate the number of days. Perform the function call in the FOR loop when creating the CSV output.
CREATE OR REPLACE PROCEDURE RentalReport
IS
	CURSOR rentalCursor IS
		SELECT r.rentalno, r.agentidcollection, p.amount, r.startdate, r.enddate
		FROM rental r, payment p
		WHERE r.rentalno = p.rentalno;
	rental_row			rentalCursor%ROWTYPE;
	numOfDays			NUMBER;
	rec_output			VARCHAR(200);
BEGIN 
	DBMS_OUTPUT.PUT_LINE('RENTAL_NUM,'||'AGENT_ID,'||'TOTAL_PAYMENT,'||'NUM_OF_DAYS');
	FOR rental_row IN rentalCursor LOOP 
		rec_output := rental_row.rentalno || ',' ||
					  rental_row.agentidcollection || ',' || 
					  rental_row.amount|| ',' ||
					  calculate_days(rental_row.startdate, rental_row.enddate);
		DBMS_OUTPUT.PUT_LINE(rec_output);
	END LOOP;
EXCEPTION
	WHEN OTHERS THEN
			ROLLBACK;
END;
/
SET SERVEROUTPUT ON;
SPOOL 'C:\Reports\RentalReportPayment.csv';
EXECUTE RentalReport;
SPOOL OFF;

-- MAINTENANCE
-- 9.1 Create a procedure called AddInvoice() which inserts data into the invoice table. The procedure performs the ff:
-- 9.1.1 Accepts parameters to insert data into the invoice table. Data is pulled from another table should not be listed as a parameter.
-- 9.1.2 Substitute the parameters for the data values in the INSERT...SELECT
-- 9.1.3 Add the UPDATE formula for the Totalamt field from the assignment script
-- 9.1.4 Test the procedure with test data to show it works
CREATE OR REPLACE PROCEDURE AddInvoice(
	in_bookingid IN invoice.bookingid%TYPE,
	in_invoiceDate IN invoice.invoicedate%TYPE,
	in_rentalPrice IN invoice.rentalprice%TYPE
)
IS
BEGIN 
	INSERT INTO invoice (invoice.bookingid, invoice.invoicedate, invoice.rentalprice) VALUES (in_bookingid, in_invoiceDate, in_rentalPrice);
	UPDATE INVOICE SET TOTALAMT = (SELECT ((BOOKING.RETURNDATE - BOOKING.COLLECTIONDATE)+1)*BOOKING.RENTALPRICE FROM BOOKING WHERE BOOKING.BOOKINGID = INVOICE.BOOKINGID);
EXCEPTION 
	WHEN OTHERS THEN 
			ROLLBACK;
END;
/
EXECUTE AddInvoice('50000039','13-JUN-17', 24.5);

-- 10. Create a procedure called CancelBook() which inserts data into the Cancel table. The procedure performs the following:
-- 10.1.2 Accepts parameters to insert data into the Cancel TABLE
-- 10.1.3 Use a function to compute the refundamt (refund amount)
-- 10.1.4 Substitute the parameters for the data values in the INSERT...SELECT statement
-- 10.1.5 Test the procedure with test data to show it works
CREATE OR REPLACE FUNCTION calculate_refund(
	in_bookingid IN invoice.bookingid%TYPE
)RETURN number 
IS
	refundAmt NUMBER;
BEGIN 
	SELECT SUM(p.amount) INTO refundAmt
	FROM payment p, booking b, rental r
	WHERE b.bookingid = in_bookingid AND b.bookingid = r.bookingid AND p.rentalno = r.rentalno;
	RETURN refundAmt;
EXCEPTION
	WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE CancelBook(
	in_bookingid IN cancel.bookingid%TYPE,
	in_cancelDate IN cancel.canceldate%TYPE
)
IS
BEGIN 
	INSERT INTO cancel (cancel.bookingid, cancel.canceldate, cancel.refundAmt) VALUES (in_bookingid, in_cancelDate, calculate_refund(in_bookingid));
EXCEPTION
	WHEN OTHERS THEN
			ROLLBACK;
END;
/
EXECUTE CancelBook('50000000','13-JAN-20');


-- TRIGGERS 
-- 11. Create triggers for the following business rules
-- 11.1 A manager can supervise no more than 2 people This trigger should occur on INSERT and UPDATE from the Agent table
-- 11.2 A vehicle can only have one booking for the same period, that is the collection date and return date for the vehicle should be unique 

--business rules for supervision no more than 2 people
CREATE OR REPLACE TRIGGER manager_check
	BEFORE INSERT OR UPDATE ON agent
FOR EACH ROW 
DECLARE 
	num_manager NUMBER;
BEGIN 
	SELECT COUNT(managerid) INTO num_manager
	FROM agent
	WHERE managerid = :NEW.managerid;

	IF num_manager > 2 THEN 
		RAISE_APPLICATION_ERROR(-20000, 'INSERT DENIED: Manager alocated too many agents');
	END IF;
END manager_check;
/
ALTER TRIGGER manager_check ENABLE;

--test if trigger is working
INSERT INTO agent (agent.agentid, agent.outletid, agent.fname, agent.lname, agent.phone, agent.commissionrate, agent.managerid) VALUES ('400410','2', 'Reg', 'Abe', '1234567', 0.5, '400401');

--business rules for one vehicle can only have one booking for the same period
CREATE OR REPLACE TRIGGER vehicleBooking_check
	BEFORE INSERT OR UPDATE ON booking
FOR EACH ROW 
DECLARE
	bad_date1 NUMBER;
	bad_date2 NUMBER;
BEGIN 
	SELECT COUNT(regno) INTO bad_date1
	FROM booking
	WHERE (regno = :NEW.regno) AND (:NEW.collectiondate BETWEEN collectiondate AND returndate);
   
	SELECT COUNT(regno) INTO bad_date2
	FROM booking
	WHERE (regno = :NEW.regno) AND (:NEW.returndate BETWEEN collectiondate AND returndate);

	IF bad_date1+bad_date2 > 0 THEN
		RAISE_APPLICATION_ERROR(-20000, 'INSERT DENIED: Vehicle already booked during these dates');
	END IF;
END vehicleBooking_check;
/
ALTER TRIGGER vehicleBooking_check ENABLE;
--test if trigger is working
INSERT INTO BOOKING(BookingDate,RegNo,CollectionDate,ReturnDate,ClientID)VALUES(TO_DATE('11-Sep-2017','dd-mm-yyyy'),'GKN534',TO_DATE('17-Sep-2017','dd-mm-yyyy'),TO_DATE('19-Oct-2017','dd-mm-yyyy'),22122);


-- PACKAGES
-- 12 with all the procedures that have been created in questions 3,4,9 and 10. Package the procedure into the following.
-- 12.1 Xcellent_Details: Which includes procedures from 3 and 4.
-- 12.2 Xcellent_Maintenance: Which includes procedures from 9 and 10.

CREATE OR REPLACE PACKAGE Xcellent_Details
IS 
	PROCEDURE RentalByMake(
		vehicleMake IN CHAR);
	PROCEDURE RentalByModel(
		vehicleModel IN CHAR);
END;
/
SHOW ERRORS;

CREATE OR REPLACE PACKAGE BODY Xcellent_Details
IS 

	PROCEDURE RentalByModel(
		vehicleModel IN CHAR
	)
	IS
		CURSOR modelCursor IS
			SELECT *
			FROM vehicle 
			WHERE model = vehicleModel;
		vehicle_row			modelCursor%ROWTYPE;
		rec_output			VARCHAR(200);
	BEGIN
		DBMS_OUTPUT.PUT_LINE('REG_NO,'||'MAKE,'||'MODEL,'||'YEAR,'||'RENTALPRICE,'||'INSURERID,'||'OUTLETID');
		FOR vehicle_row IN modelCursor LOOP
			rec_output := vehicle_row.regno || ',' ||
						  vehicle_row.make || ',' ||
						  vehicle_row.model || ',' ||
						  vehicle_row.year || ',' ||
						  vehicle_row.rentalprice || ',' ||
						  vehicle_row.insurerid || ',' ||
						  vehicle_row.outletid;
				DBMS_OUTPUT.PUT_LINE(rec_output);
		END LOOP;
	EXCEPTION 
		WHEN OTHERS THEN 
				ROLLBACK;
	END RentalByModel;
	
	PROCEDURE RentalByMake(
	vehicleMake IN CHAR
	)
	IS
		CURSOR makeCursor IS
			SELECT *
			FROM vehicle 
			WHERE make = vehicleMake;
		vehicle_row			makeCursor%ROWTYPE;
		rec_output			VARCHAR(200);
	BEGIN
		DBMS_OUTPUT.PUT_LINE('REG_NO,'||'MAKE,'||'MODEL,'||'YEAR,'||'RENTALPRICE,'||'INSURERID,'||'OUTLETID');
		FOR vehicle_row IN makeCursor LOOP
			rec_output := vehicle_row.regno || ',' ||
						  vehicle_row.make || ',' ||
						  vehicle_row.model || ',' ||
						  vehicle_row.year || ',' ||
						  vehicle_row.rentalprice || ',' ||
						  vehicle_row.insurerid || ',' ||
						  vehicle_row.outletid;
				DBMS_OUTPUT.PUT_LINE(rec_output);
		END LOOP;
	EXCEPTION 
		WHEN OTHERS THEN 
				ROLLBACK;
	END RentalByMake;
	
END;
/
SHOW ERRORS;

--Xcellent_Maintenance Package

CREATE OR REPLACE PACKAGE Xcellent_Maintenance
IS 
	PROCEDURE AddInvoice(
		in_bookingid IN invoice.bookingid%TYPE,
		in_invoiceDate IN invoice.invoicedate%TYPE,
		in_rentalPrice IN invoice.rentalprice%TYPE
	);
	FUNCTION calculate_refund(
		in_bookingid IN invoice.bookingid%TYPE
	) RETURN number;
END;
/
SHOW ERRORS;

CREATE OR REPLACE PACKAGE BODY Xcellent_Maintenance
IS 
	PROCEDURE AddInvoice(
		in_bookingid IN invoice.bookingid%TYPE,
		in_invoiceDate IN invoice.invoicedate%TYPE,
		in_rentalPrice IN invoice.rentalprice%TYPE
	)
	IS
	BEGIN 
		INSERT INTO invoice (invoice.bookingid, invoice.invoicedate, invoice.rentalprice) VALUES (in_bookingid, in_invoiceDate, in_rentalPrice);
		UPDATE INVOICE SET TOTALAMT = (SELECT ((BOOKING.RETURNDATE - BOOKING.COLLECTIONDATE)+1)*BOOKING.RENTALPRICE FROM BOOKING WHERE BOOKING.BOOKINGID = INVOICE.BOOKINGID);
	EXCEPTION 
		WHEN OTHERS THEN 
				ROLLBACK;
	END AddInvoice;
	
	FUNCTION calculate_refund(
	in_bookingid IN invoice.bookingid%TYPE
	)RETURN number 
	IS
		refundAmt NUMBER;
	BEGIN 
		SELECT SUM(p.amount) INTO refundAmt
		FROM payment p, booking b, rental r
		WHERE b.bookingid = in_bookingid AND b.bookingid = r.bookingid AND p.rentalno = r.rentalno;
		RETURN refundAmt;
	EXCEPTION
		WHEN OTHERS THEN 
			DBMS_OUTPUT.PUT_LINE(SQLERRM);
	END calculate_refund;
END;
/
SHOW ERRORS;
	
