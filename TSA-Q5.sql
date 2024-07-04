CREATE TABLE JOBS (
    job_id VARCHAR2(10) PRIMARY KEY,
    job_title VARCHAR2(50) NOT NULL,
    min_salary NUMBER(10, 2),
    max_salary NUMBER(10, 2)
);

CREATE OR REPLACE PACKAGE JOB_PKG AS
    -- Procedure to add a new job
    PROCEDURE ADD_JOB (
        p_job_id     IN JOBS.job_id%TYPE,
        p_job_title  IN JOBS.job_title%TYPE,
        p_min_salary IN JOBS.min_salary%TYPE,
        p_max_salary IN JOBS.max_salary%TYPE
    );
END JOB_PKG;
/

CREATE OR REPLACE PACKAGE BODY JOB_PKG AS

    -- Private procedure for salary validation
    PROCEDURE VALIDATE_SALARY (
        p_min_salary IN JOBS.min_salary%TYPE,
        p_max_salary IN JOBS.max_salary%TYPE
    ) IS
    BEGIN
        IF p_max_salary <= p_min_salary THEN
            RAISE_APPLICATION_ERROR(-20001, 'Maximum salary must be greater than minimum salary.');
        END IF;
    END VALIDATE_SALARY;

    -- Procedure to add a new job
    PROCEDURE ADD_JOB (
        p_job_id     IN JOBS.job_id%TYPE,
        p_job_title  IN JOBS.job_title%TYPE,
        p_min_salary IN JOBS.min_salary%TYPE,
        p_max_salary IN JOBS.max_salary%TYPE
    ) IS
    BEGIN
        -- Call the salary validation procedure
        VALIDATE_SALARY(p_min_salary, p_max_salary);

        -- Insert the new job into the JOBS table
        INSERT INTO JOBS (job_id, job_title, min_salary, max_salary)
        VALUES (p_job_id, p_job_title, p_min_salary, p_max_salary);

        -- Commit the transaction
        COMMIT;
    END ADD_JOB;

END JOB_PKG;
/

BEGIN
    -- This should succeed
    JOB_PKG.ADD_JOB('J001', 'Software Engineer', 50000, 70000);
     DBMS_OUTPUT.PUT_LINE('Job J001 added successfully.');

    -- This should succeed
    JOB_PKG.ADD_JOB('J002', 'Data Analyst', 45000, 60000);
     DBMS_OUTPUT.PUT_LINE('Job J002 added successfully.');

    -- This should fail with an error
    JOB_PKG.ADD_JOB('J003', 'Manager', 60000, 55000);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
