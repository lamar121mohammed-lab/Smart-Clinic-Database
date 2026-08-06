SELECT FirstName, LastName, Phone
FROM Patient;

SELECT
P.FirstName,
P.LastName,
D.FirstName AS DoctorName,
A.AppointmentDate,
A.Status
FROM Appointment A
JOIN Patient P
ON A.PatientID = P.PatientID
JOIN Doctor D
ON A.DoctorID = D.DoctorID;
SELECT FirstName, LastName
FROM Patient
WHERE PatientID IN
(
SELECT PatientID
FROM Appointment
WHERE Status = 'Completed'
);
SELECT
PaymentMethod,
COUNT(*) AS TotalPayments,
SUM(Amount) AS TotalAmount
FROM Payment
GROUP BY PaymentMethod;
UPDATE Medicine
SET Quantity = 90
WHERE MedicineID = 3;
SELECT *
FROM Medicine;
INSERT INTO Employee(Name, Phone)
VALUES ('Khalid Salem', '0569999999');

DELETE FROM Employee
WHERE EmployeeID = 11;
SELECT *
FROM Employee;
CREATE VIEW PatientAppointments AS
SELECT
P.FirstName,
P.LastName,
A.AppointmentDate,
A.Status
FROM Patient P
JOIN Appointment A
ON P.PatientID = A.PatientID;

SELECT *
FROM PatientAppointments;

DROP TRIGGER IF EXISTS CheckPaymentAmount;

DELIMITER $$

CREATE TRIGGER CheckPaymentAmount
BEFORE INSERT ON Payment
FOR EACH ROW
BEGIN
    IF NEW.Amount < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment amount cannot be negative';
    END IF;
END$$

DELIMITER ;

INSERT INTO Payment
(PaymentID, AppointmentID, Amount, PaymentDate, PaymentMethod)
VALUES
(6, 6, -100, '2026-08-10', 'Cash');