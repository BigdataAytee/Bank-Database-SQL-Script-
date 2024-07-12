'''
This script sets up a comprehensive database structure for a banking system named bank_database. The script performs the following tasks:

	Create and Use Database: It begins by creating the bank_customer database and then sets it as the active database.
	Customer Table: Creates a table to store customer details, including their personal information.
	Accounts Table: Creates a table to manage customer accounts, linking each account to a customer.
	Transactions Table: Establishes a table for recording transactions related to each account.
	Employees Table: Creates a table to store employee information.
	Branches Table: Creates a table to manage branch details.
	EmployeeBranch Table: Defines a many-to-many relationship between employees and branches.
	Loans Table: Sets up a table to manage loan information.
	LoanPayment Table: Creates a table to record payments made towards loans.'''

create database bank_db
use bank_db

--- create customer table 
create table customer (
	CustomerID INT IDENTITY(1,1) Primary Key,
	Firstname varchar(50) not null,
	LastName varchar (50) not null, 
	DateOfBirth Date,
	Address Varchar(255),
	PhoneNumber Varchar(20),
	Email varchar(100) unique
	
);

--- create account table
create table Accounts (
	AccountID INT identity PRIMARY KEY,
	CustomerID INT,
	AccountType varchar(50),
	Balance DECIMAL(38, 2) DEFAULT 0.00,
	CreatedAt DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (CustomerID) REFERENCES customer(CustomerID)

);

--- create transaction table
CREATE TABLE Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT,
    TransactionType VARCHAR(50),
    Amount DECIMAL(38, 2) DEFAULT 0.00,
    TransactionDate DATETIME DEFAULT GETDATE(),
    Description VARCHAR(200),
    FOREIGN KEY (AccountID) REFERENCES Accounts (AccountID)
);

-- Create the employee table

create Table Employees (
	EmployeeID INT IDENTITY(202401, 202401) PRIMARY KEY,
	FirstName VARCHAR(100) NOT NULL,
	LastName VARCHAR(100) NOT NULL,
	Position VARCHAR(100),
	Department VARCHAR(50),
	Salary DECIMAL (38, 2),
	DateHired DATE
);

-- creqat the branches table
creatE table Branches (
	BranchID INT IDENTITY (101, 101) PRIMARY KEY,
	BranchName VARCHAR(100),
	BranchAddress VARCHAR(255),
	BranchPhone VARCHAR(100)

);




--- Create the employeeBranch Table for the many to many relationshp
create table EmployeeBranch(
	EmployeeID INT,
	BranchID INT,
	PRIMARY KEY (EmployeeID, BranchID),
	FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
	FOREIGN KEY (BranchID) REFERENCES Branches (BranchID)

);


-- Create loan table
create table loans (
	LoanID INT IDENTITY(1, 1) PRIMARY KEY,
	CustomerID INT,
	LoanAmount DECIMAL(38, 2),
	InterestRate Decimal (5, 2),
	LoanTerm INT, -- In months
	StartDate DATE,
	FOREIGN KEY (CustomerID) REFERENCES customer(CustomerID)
);

-- create loan payment table 

create table LoanPayment (
	PaymentID INT IDENTITY(1,1) PRIMARY KEY,
	LoanID INT,
	PaymentAmount Decimal(38, 2),
	PaymentDate DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (LoanID) REFERENCES loans(loanID)
);

-- Insert sample data into Customers
INSERT INTO customer (FirstName, LastName, DateOfBirth, Address, PhoneNumber, Email)
VALUES
('John', 'Doe', '1980-01-01', '123 Main St, Anytown, USA', '555-1234', 'johndoe@example.com'),
('Jane', 'Smith', '1985-02-02', '456 Elm St, Othertown, USA', '555-5678', 'janesmith@example.com');

-- Insert sample data into Accounts
INSERT INTO Accounts (CustomerID, AccountType, Balance)
VALUES
(1, 'Checking', 1500.00),
(1, 'Savings', 3000.00),
(2, 'Checking', 2000.00);

-- Insert sample data into Transactions
INSERT INTO Transactions (AccountID, TransactionType, Amount, Description)
VALUES
(1, 'Deposit', 500.00, 'Initial Deposit'),
(2, 'Withdrawal', 200.00, 'ATM Withdrawal'),
(3, 'Deposit', 1000.00, 'Paycheck Deposit');

-- Insert sample data into Employees
INSERT INTO Employees (FirstName, LastName, Position, Department, Salary, DateHired)
VALUES
('Alice', 'Johnson', 'Manager','IT', 80000.00, '2015-03-15'),
('Bob', 'Williams', 'Teller','Customer Service', 40000.00, '2018-06-01');

-- Insert sample data into Branches
INSERT INTO Branches (BranchName, BranchAddress, BranchPhone)
VALUES
('Main Branch', '100 Bank St, Big City, USA', '555-1000'),
('East Branch', '200 Finance Ave, Big City, USA', '555-2000');

-- Insert sample data into EmployeeBranch

INSERT INTO EmployeeBranch (EmployeeID, BranchID)
select e.EmployeeID, b.BranchID
FROM Employees e, Branches b

union 
select e.employeeID, b.BranchID
FROM Employees e, Branches b

-- Insert sample data into Loans
INSERT INTO Loans (CustomerID, LoanAmount, InterestRate, LoanTerm, StartDate)
VALUES
(1, 50000.00, 5.0, 60, '2020-01-01'),
(2, 100000.00, 4.5, 120, '2019-06-15');

-- Insert sample data into LoanPayments
INSERT INTO LoanPayment (LoanID, PaymentAmount)
VALUES
(1, 1000.00),
(2, 1500.00);






'''The script successfully creates a comprehensive database schema for the bank_ database. It includes tables for managing customers, 
accounts, transactions, employees, branches, loans, and loan payments, with appropriate foreign key relationships to maintain data integrity and support various banking operations.
This structure ensures a well-organized and relationally sound database design to support the functionalities of a banking system.

'''

