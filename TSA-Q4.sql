-- Create the EMPLOYEES table
CREATE TABLE EMPLOYEES (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(100),
    last_name VARCHAR2(100),
    department_id NUMBER
);

-- Insert sample data into EMPLOYEES table
INSERT INTO EMPLOYEES (employee_id, first_name, last_name, department_id)
VALUES (1, 'John', 'Doe', 50);

INSERT INTO EMPLOYEES (employee_id, first_name, last_name, department_id)
VALUES (2, 'Jane', 'Smith', 50);

INSERT INTO EMPLOYEES (employee_id, first_name, last_name, department_id)
VALUES (3, 'Alice', 'Johnson', 30);

INSERT INTO EMPLOYEES (employee_id, first_name, last_name, department_id)
VALUES (4, 'Bob', 'Brown', 50);

INSERT INTO EMPLOYEES (employee_id, first_name, last_name, department_id)
VALUES (5, 'Carol', 'White', 40);

-- Commit the data
COMMIT;

-- Create the full_name function
CREATE OR REPLACE FUNCTION full_name (
    p_last_name IN VARCHAR2,
    p_first_name IN VARCHAR2
) RETURN VARCHAR2 AS
    v_full_name VARCHAR2(200);
BEGIN
    -- Concatenate last name, comma, space, and first name
    v_full_name := p_last_name || ', ' || p_first_name;
    
    -- Return the full name
    RETURN v_full_name;
END;
/

-- SELECT statement to display the full name using the function
SELECT DISTINCT
    full_name(last_name, first_name) AS full_name
FROM
    EMPLOYEES
WHERE
    department_id = 50;
