-- Create Procedure
CREATE PROCEDURE CalculateTotalAmount(orderid IN VARCHAR, regular_q IN INT, 
  regular_p IN DECIMAL, special_q IN INT, special_p IN DECIMAL, fee IN DECIMAL) AS
BEGIN
UPDATE orders
SET total_amount = regular_q * regular_p + special_q * special_p + fee
WHERE order_id = orderid;
END CalculateTotalAmount;

-- Create new table to store the audited results
CREATE TABLE TotalAmountAudit(
  order_id VARCHAR(20),
  old_total_amount DECIMAL(10,2),
  new_total_amount DECIMAL(10,2),
  isMatch VARCHAR(10)
);

-- Create trigger
CREATE TRIGGER TotalAmountAudit
BEFORE UPDATE ON orders
FOR EACH ROW 
BEGIN
IF :OLD.total_amount != :NEW.total_amount THEN
INSERT INTO TotalAmountAudit (order_id, old_total_amount, new_total_amount, isMatch)
VALUES (:OLD.order_id, :OLD.total_amount, :NEW.total_amount, 'False');
ELSE
INSERT INTO TotalAmountAudit (order_id, old_total_amount, new_total_amount, isMatch)
VALUES (:OLD.order_id, :OLD.total_amount, :NEW.total_amount, 'True');
END IF;
END;

-- Testing
CALL CalculateTotalAmount('389531283', 2, 13.79, 0, 12.29, 3.78);

SELECT * FROM TotalAmountAudit;