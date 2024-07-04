-- Create the COUNTRIES table
CREATE TABLE COUNTRIES (
    country_id NUMBER PRIMARY KEY,
    country_name VARCHAR2(100),
    region_id NUMBER,
    highest_elevation NUMBER
);

-- Insert sample data into COUNTRIES table
INSERT INTO COUNTRIES (country_id, country_name, region_id, highest_elevation) VALUES (1, 'CountryA', 5, 2500);
INSERT INTO COUNTRIES (country_id, country_name, region_id, highest_elevation) VALUES (2, 'CountryB', 3, 1500);
INSERT INTO COUNTRIES (country_id, country_name, region_id, highest_elevation) VALUES (3, 'CountryC', 5, 3000);
INSERT INTO COUNTRIES (country_id, country_name, region_id, highest_elevation) VALUES (4, 'CountryD', 4, 2800);
INSERT INTO COUNTRIES (country_id, country_name, region_id, highest_elevation) VALUES (5, 'CountryE', 4, 1000);
INSERT INTO COUNTRIES (country_id, country_name, region_id, highest_elevation) VALUES (6, 'CountryF', 1, 2200);
INSERT INTO COUNTRIES (country_id, country_name, region_id, highest_elevation) VALUES (7, 'CountryG', 5, 1800);

-- Commit the data
COMMIT;

-- Create the procedure
CREATE OR REPLACE PROCEDURE GetCountriesByElevation (
    p_region_id IN NUMBER,
    p_elevation_value IN NUMBER
) AS
    v_country_count NUMBER;
BEGIN
    -- Query to count the number of countries in the specified region
    -- whose highest elevations exceed the given value
    SELECT COUNT(*)
    INTO v_country_count
    FROM COUNTRIES
    WHERE region_id = p_region_id
      AND highest_elevation > p_elevation_value;

    -- Display the result
    DBMS_OUTPUT.PUT_LINE('Number of countries in region ' || p_region_id ||
                         ' with highest elevation greater than ' || p_elevation_value || ': ' || v_country_count);
END;
/

-- Test the procedure
BEGIN
    -- Enable DBMS_OUTPUT
    DBMS_OUTPUT.ENABLE;

    -- Call the procedure with test values
    GetCountriesByElevation(5, 2000);
    GetCountriesByElevation(3, 3200);
    GetCountriesByElevation(4, 2000);
END;
/
