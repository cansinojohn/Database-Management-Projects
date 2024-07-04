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

-- Test the full_name function using an anonymous block
DECLARE
    v_full_name VARCHAR2(200);
BEGIN
    -- Call the function and store the result in the local variable
    v_full_name := full_name('Smith', 'Joe');
    
    -- Display the result using DBMS_OUTPUT.PUT_LINE
    DBMS_OUTPUT.PUT_LINE('Employee 1: ' || v_full_name);
    
    -- Call the function with another set of values and store the result in the local variable
    v_full_name := full_name('Doe', 'John');
    
    -- Display the result using DBMS_OUTPUT.PUT_LINE
    DBMS_OUTPUT.PUT_LINE('Employee 2: ' || v_full_name);
END;
/
