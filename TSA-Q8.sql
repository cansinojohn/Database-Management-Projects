CREATE TABLE JOBS (
    job_id VARCHAR2(10) PRIMARY KEY,
    job_title VARCHAR2(50) NOT NULL,
    min_salary NUMBER(10, 2),
    max_salary NUMBER(10, 2)
);

INSERT INTO JOBS (job_id, job_title, min_salary, max_salary)
VALUES ('J001', 'Software Engineer', 50000, 100000);

INSERT INTO JOBS (job_id, job_title, min_salary, max_salary)
VALUES ('J002', 'Data Analyst', 40000, 80000);

INSERT INTO JOBS (job_id, job_title, min_salary, max_salary)
VALUES ('J003', 'Manager', 60000, 120000);

COMMIT;

CREATE TABLE EMPLOYEES (
    employee_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    job_id VARCHAR2(10) REFERENCES JOBS(job_id),
    salary NUMBER(10, 2)
);

COMMIT;

CREATE OR REPLACE PROCEDURE CHECK_SALARY (
    p_job_id   IN JOBS.job_id%TYPE,
    p_salary   IN NUMBER
) IS
    v_min_salary JOBS.min_salary%TYPE;
    v_max_salary JOBS.max_salary%TYPE;
BEGIN
    -- Retrieve min_salary and max_salary for the given job_id
    SELECT min_salary, max_salary
    INTO v_min_salary, v_max_salary
    FROM JOBS
    WHERE job_id = p_job_id;

    -- Check if p_salary falls outside the allowed range
    IF p_salary < v_min_salary OR p_salary > v_max_salary THEN
        RAISE_APPLICATION_ERROR(-20001, 'Invalid salary ' || p_salary || '. Salaries for job ' || p_job_id || 
                                  ' must be between ' || v_min_salary || ' and ' || v_max_salary);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Salary check passed successfully.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Job ID not found: ' || p_job_id);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error checking salary: ' || SQLERRM);
END CHECK_SALARY;
/

CREATE OR REPLACE TRIGGER CHECK_SALARY_TRG
BEFORE INSERT OR UPDATE ON EMPLOYEES
FOR EACH ROW
BEGIN
    -- Call the CHECK_SALARY procedure to validate salary for the new job_id
    CHECK_SALARY(:NEW.job_id, :NEW.salary);
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20004, 'Error in salary check trigger: ' || SQLERRM);
END CHECK_SALARY_TRG;
/

BEGIN
    -- Valid salary check
    CHECK_SALARY('J001', 80000);  -- Should pass

    -- Invalid salary check (outside range)
    CHECK_SALARY('J002', 100000);  -- Should raise error
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

BEGIN
    INSERT INTO EMPLOYEES (job_id, salary)
    VALUES ('J001', 90000);  -- Should pass
    
    UPDATE EMPLOYEES
    SET salary = 110000
    WHERE job_id = 'J001';
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

-- Anonymous block to insert a new record into EMPLOYEES table
BEGIN
    INSERT INTO EMPLOYEES (employee_id, job_id, salary)
    VALUES (777, 'IT_DBADM', 20000);
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Employee record inserted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

