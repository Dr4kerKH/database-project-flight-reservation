
--1.What are some payment information of John Doe such as the amount spent, payment date, payment time and payment method?
SELECT Payment_Amount, Customer.LastName, Customer.FirstName, Payment.TicketID, Payment_Date,Payment_Time, Payment_Method
FROM Payment INNER JOIN ticket ON Payment.TicketID = ticket.TicketID
	INNER JOIN Customer ON ticket.CustomerID = Customer.CustomerID
where Customer.FirstName = "John" and Customer.LastName = "Doe";

--2.   What is the flight information in June 2023?
SELECT * FROM flight
WHERE Depature_Date LIKE "%2023-06%"
ORDER BY Flight_Num;

--3.   How many available ticket in Business class of Flight 106?
SELECT (Class.Capacity - COUNT(TicketID)) AS Availabli_Ticket
FROM ticket INNER JOIN Class ON ticket.ClassID = Class.ClassID
	INNER JOIN Flight ON ticket.Flight_Num = Flight.Flight_Num
WHERE Class.ClassID = '106BUS' and Flight.Flight_Num = 106;

--4.  What are all the passenger information on flight number 106?
SELECT Customer.CustomerID, FirstName, LastName, Gender, DOB, Contact_Num, Customer.Email, Passport_Num
From Customer Inner Join ticket On Customer.CustomerID = ticket.CustomerID
    Inner Join Flight On Flight.Flight_Num = ticket.Flight_Num
Where ticket.Flight_Num = 106;

--5. Update the necessary information about flight 103 such as Flight Status and Time due to 30 minutes delay.
SELECT * FROM flight
WHERE Flight_Num = 103;

UPDATE flight
SET Departure_Time = DATE_ADD(Departure_Time, INTERVAL 30 MINUTE),
    Arrival_Time = DATE_ADD(Arrival_Time, INTERVAL 30 MINUTE),
    Flight_Status = 'Delayed'
WHERE Flight_Num = 103;

SELECT * FROM flight
WHERE Flight_Num = 103;

--6.  What are all the code which represents airport or airline?
SELECT Airport_Code AS Code, Airport_Name AS Name, 'Airport' AS Type
FROM Airport
UNION
SELECT Airline_ID AS Code, Airline_Name AS Name, 'Airline' AS Type
FROM Airline;

--7. Which flight has economy price ticket higher than business class from other flight ?
SELECT Ticket.TicketID, Ticket.CustomerID, Ticket.Flight_Num, Ticket.ClassID, Payment.Payment_Amount
FROM ticket INNER JOIN Payment ON ticket.TicketID = Payment.TicketID
WHERE ticket.ClassID LIKE '%ECO' AND Payment.Payment_Amount > ANY 
		(
    	SELECT Payment.Payment_Amount 
    	FROM Payment INNER JOIN ticket ON ticket.TicketID = Payment.TicketID
    	WHERE ticket.ClassID LIKE '%BUS'
   		);
        
--8.  What is the total revenue generated from Flight 104?
SELECT Flight.Flight_Num AS Flight,
	Flight.AirlineID, Airline.Airline_Name,
    Flight.DepAirport_Code AS Departure,
	Flight.Departure_Date AS Date,
    Flight.ArrAirport_Code AS Arrival,
    Flight.Arrival_Date AS Date,
    CONCAT('$', FORMAT(SUM(Payment.Payment_Amount), 2)) AS Total_Revenue
FROM Payment INNER JOIN ticket on Payment.TicketID = ticket.TicketID 
		INNER JOIN Flight on ticket.Flight_Num = Flight.Flight_Num
		INNER JOIN Airline on Flight.AirlineID = Airline.Airline_ID 
Where Flight.Flight_Num = 104;

--9.  Delete the information about Flight 101, and the other information that refers to it.
SELECT * FROM Flight;

DELETE FROM flight
WHERE Flight_Num = 101;

SELECT Customer.CustomerID, Customer.FirstName, Customer.LastName, Customer.DOB, Customer.Email,
		Customer.Passport_Num, Ticket.TicketID, Flight.Flight_Num
FROM Customer INNER JOIN Ticket ON Ticket.CustomerID = Customer.CustomerID
	INNER JOIN Flight ON Ticket.Flight_Num = Flight.Flight_Num;