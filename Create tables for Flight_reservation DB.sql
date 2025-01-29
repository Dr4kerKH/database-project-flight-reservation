CREATE Table Airport (
	Airport_Code CHAR(3) PRIMARY KEY Not Null,
	Airport_Name VARCHAR(48) Not Null,
    Location VARCHAR(18),
    Country VARCHAR(12)
);

CREATE Table Airline (
	Airline_ID CHAR(4) PRIMARY KEY Not Null,
    Airline_Name VARCHAR(32) Not Null,
    Contact_Num INT,
    Email VARCHAR(32)
);

CREATE Table Flight (
	Flight_Num INT PRIMARY KEY Not Null,
    AirlineID CHAR(4) Not Null,
    DepAirport_Code CHAR(3) Not Null,
    ArrAirport_Code CHAR(3) Not Null,
    Departure_Date DATE Not Null,
    Arrival_Date Date Not Null,
    Departure_Time TIME Not Null,
    Arrival_Time TIME Not Null,
    Duration INT,
    Gate_N INT Not Null,
    Terminal CHAR(4),
    Flight_Status VARCHAR(16),
    FOREIGN KEY(AirlineID) references Airline(Airline_ID),
    FOREIGN KEY(DepAirport_Code) references Airport(Airport_Code),
    FOREIGN KEY(ArrAirport_Code) references Airport(Airport_Code)
);

CREATE Table Class (
	ClassID VARCHAR(16) PRIMARY KEY Not Null,
    Flight_Num INT,
    Class_Name VARCHAR(16) Not Null,
    Capacity INT,
    FOREIGN KEY(Flight_Num) references Flight(Flight_Num) ON DELETE CASCADE
);

CREATE Table Customer (
	CustomerID INT PRIMARY KEY Not Null,
    FirstName VARCHAR(16) Not Null,
    LastName VARCHAR(16) Not Null,
    Gender VARCHAR(8),
    DOB DATE Not Null,
    Contact_Num INT,
    Email VARCHAR(32),
	Passport_Num VARCHAR(9)
);

CREATE Table ticket (
  TicketID INT PRIMARY KEY Not Null,
  CustomerID INT Not Null, 
  Flight_Num INT Not Null,
  ClassID VARCHAR(16),
  Seat_Num VARCHAR(4),
  Reservation_Date DATE,
  Reservation_Time TIME,
  FOREIGN KEY(CustomerID) references Customer(CustomerID),
  FOREIGN KEY(Flight_Num) references Flight(Flight_Num) ON DELETE CASCADE,
  FOREIGN KEY(ClassID) references Class(ClassID) ON DELETE CASCADE
);

CREATE Table Payment (
	PaymentID INT PRIMARY KEY Not Null,
    TicketID INT Not Null,
    Payment_Amount INT,
    Payment_Date DATE,
    Payment_Time TIME,
    Payment_Method VARCHAR(32),
    FOREIGN KEY(TicketID) references ticket(TicketID) ON DELETE CASCADE
);