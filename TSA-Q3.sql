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

BEGIN
    -- Test the full_name function
    DBMS_OUTPUT.PUT_LINE(full_name('Smith', 'Joe'));
    DBMS_OUTPUT.PUT_LINE(full_name('Doe', 'John'));
END;
/
