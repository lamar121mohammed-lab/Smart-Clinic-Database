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