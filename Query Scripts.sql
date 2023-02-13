-- Show a list of all vehicles that are owned by Xcellent Rental. Display the Registration, Make, Model, Year, Rental price and Current assigned outlet
SET sqlformat csv;
SPOOL "C:\Reports\VehiclesReport.csv";
	SELECT regno "Registration", make "Make", model "Model", year "Year", rentalprice "Rental Price", outletid "Outlet"
	FROM vehicle;
SPOOL OFF;

-- Find the agent that have made a booking (collected from). Display appropriate headings and make sure that there are no repeated data.
SET sqlformat csv;
SPOOL "C:\Reports\AgentReport.csv";
	SELECT a.fname || ' ' || a.lname "Agents that made a booking"
	FROM agent a, booking b, rental r
	WHERE b.bookingid = r.bookingid AND r.agentidcollection = a.agentid
	GROUP BY a.fname || ' ' || a.lname
	HAVING COUNT(b.bookingid) > 0;
SPOOL OFF;

-- Find the MAX, MIN, and AVG daily rental price for the vehicles at Xcellent Rental. Display with headings “Max Rate”, “Min Rate”, and “Average Rate”.
SET sqlformat csv;
SPOOL "C:\Reports\VehicleRentalPriceReport.csv";
	SELECT MAX(rentalprice) "Max Rental Price", MIN(rentalprice) "Min Rental Price", AVG(rentalprice) "Avg Rental Price"
	FROM vehicle;
SPOOL OFF;

-- Find the number of Rental at each outlet including the MAX, MIN, and AVG daily rental prices.
SET sqlformat csv;
SPOOL "C:\Reports\OutletReport.csv";
	SELECT o.outletid "Outlet ID", COUNT(r.rentalno) "Rental Count", MAX(v.rentalprice) "Max Rate", MIN(v.rentalprice) "Min Rate", AVG(v.rentalprice) "Average Rate"
	FROM vehicle v, outlet o, rental r, agent a, booking b
	WHERE o.outletid = a.outletid AND a.agentid = r.agentidcollection AND r.bookingid = b.bookingid AND b.regno = v.regno
	GROUP BY o.outletid;
SPOOL OFF;
 
-- Find all vehicles that has been booked but not yet collected including the name of the clients. 
SET sqlformat csv;
SPOOL "C:\Reports\VehicleBookReport.csv";
	SELECT b.regno "Vehicle RegNo", c.fname || ' ' || c.lname "Client Name"
	FROM booking b, client c 
	WHERE c.clientid = b.clientid AND b.collectiondate IS NULL;
SPOOL OFF;

-- Find vehicles that have been collected but not returned including the name of the clients.
SET sqlformat csv;
SPOOL "C:\Reports\VehicleBookReport.csv";
	SELECT b.regno "Vehicle RegNo", c.fname || ' ' || c.lname "Client Name"
	FROM booking b, client c 
	WHERE c.clientid = b.clientid AND b.collectiondate IS NOT NULL AND b.returndate IS NULL;
SPOOL OFF;

-- Show a list of vehicles that have been rented for over 10 days. Display the Rental Number, the Registration, Clients Name, agent Code, and Days rented.
SET sqlformat csv;
SPOOL "C:\Reports\VehicleOver10DaysReport.csv";
	SELECT r.rentalno "Rental Number", b.regno "Registration", c.fname || ' ' || c.lname "Client Name", r.agentidcollection "Agent Code", r.enddate - r.startdate "Days Rented"
	FROM rental r, client c, booking b
	WHERE b.bookingid = r.bookingid AND b.clientid = c.clientid AND (r.enddate - r.startdate) + 1 > 10;
SPOOL OFF;

-- Display all the payments that have been made in descending order of amount. Include the Payment Number, Client Name, Date and Amount in the display.
SET sqlformat csv;
SPOOL "C:\Reports\VehiclePaymentDESCReport.csv";
	SELECT p.paymentid "Payment Number", c.fname || ' ' || c.lname "Client Name", p.paydate "Date", p.amount "Amount"  
	FROM payment p, client c
	WHERE p.clientid = c.clientid
	ORDER BY p.amount DESC;
SPOOL OFF;

/*  Display the number of payments and total payments that have been made by a client for a rental. 
	Include the Rental Number, Clients Name, Number of Payments and the Total Amount paid on the rental. 
	Order by ascending Rental Number. Use appropriate heading displays. */
SET sqlformat csv;
SPOOL "C:\Reports\VehicleClientPaymentReport.csv";
    SELECT p.rentalno "Rental Number", c.fname || ' ' || c.lname "ClientName", COUNT(p.paymentid) "Number of Payments", SUM(p.amount) "Total Amount Paid"
    FROM payment p, client c
    WHERE p.clientid = c.clientid
    GROUP BY p.rentalno, c.fname || ' ' || c.lname
    ORDER BY p.rentalno;
SPOOL OFF;



