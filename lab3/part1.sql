#
# Database Systems - Lab 3
#

# Modify this file to achieve the requirements listed in Part 1 of the Lab 3
# specifications.

DROP PROCEDURE IF EXISTS sp_pay_raise;

DELIMITER $$

CREATE PROCEDURE sp_pay_raise(
    IN inEmpID INT,
    IN inPercentageRaise DOUBLE(4,2),
    OUT errorCode INT
)
BEGIN
    DECLARE empExists INT;
    
    SELECT COUNT(*) INTO empExists FROM Employee WHERE empID = inEmpID;
    
    IF empExists = 0 THEN
        IF inPercentageRaise <= 0 OR inPercentageRaise >= 10 THEN
            SET errorCode = -3;
        ELSE
            SET errorCode = -2;
        END IF;
    ELSE
        IF inPercentageRaise <= 0 OR inPercentageRaise >= 10 THEN
            SET errorCode = -1;
        ELSE
            UPDATE Employee
            SET salary = salary + (salary * (inPercentageRaise / 100))
            WHERE empID = inEmpID;
            
            SET errorCode = 0;
        END IF;
    END IF;
END$$

DELIMITER ;

