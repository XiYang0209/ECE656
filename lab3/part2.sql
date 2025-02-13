#
# Database Systems - Lab 3
#

# Modify this file to achieve the requirements listed in Part 2 of the Lab 3
# specifications.

DROP PROCEDURE IF EXISTS sp_pay_raise_kitchener;

DELIMITER //

CREATE PROCEDURE sp_pay_raise_kitchener()
BEGIN
    DECLARE employeeCount INT;
    DECLARE maxSalaryAfterRaise DECIMAL(10,2);

    -- Start a transaction
    START TRANSACTION;

    -- Count the number of employees in Kitchener
    SELECT COUNT(*) INTO employeeCount 
    FROM Employee e
    JOIN Location l ON e.deptID = l.locID
    WHERE l.cityName = 'Kitchener';

    -- If no employees in Kitchener, return 0 immediately
    IF employeeCount = 0 THEN
        ROLLBACK;
        SELECT 0 AS result;
        LEAVE proc_exit;
    END IF;

    -- Update salaries by 3%
    UPDATE Employee 
    SET salary = salary * 1.03
    WHERE deptID IN (SELECT locID FROM Location WHERE cityName = 'Kitchener');

    -- Check the maximum salary after the raise
    SELECT MAX(salary) INTO maxSalaryAfterRaise
    FROM Employee 
    WHERE deptID IN (SELECT locID FROM Location WHERE cityName = 'Kitchener');

    -- If any salary exceeds $50,000, rollback and return 1
    IF maxSalaryAfterRaise > 50000 THEN
        ROLLBACK;
        SELECT 1 AS result;
    ELSE
        COMMIT;
        SELECT 0 AS result;
    END IF;

    -- Exit point for the procedure
    proc_exit: END;
END //

DELIMITER ;
