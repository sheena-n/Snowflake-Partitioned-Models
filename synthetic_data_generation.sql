/*-----------------------------------------------------------------------------
Generate synthetic data: 2-year monthly historical CLV for 100m subscribers

Script:       01_synthetic_data_generation.sql
Author:       Sheena Nasim
Last Updated: 04/11/2024
-----------------------------------------------------------------------------*/

-- Create Database,schema and warehouse
CREATE OR REPLACE DATABASE CUSTOMER_SYNTHETIC_DATA;
CREATE OR REPLACE SCHEMA CLTV;
CREATE OR REPLACE WAREHOUSE CUSTOMER_CLTV WITH WAREHOUSE_SIZE = 'X4LARGE' AUTO_SUSPEND = 60;
USE WAREHOUSE CUSTOMER_CLTV;

-- Generate synthetic data: 2-year monthly historical CLV for 60m subscribers
-- Create temp table for dates
CREATE OR REPLACE TEMPORARY TABLE CUSTOMER_SYNTHETIC_DATA.CLTV.MONTH_DATE AS (
    SELECT DATEADD(MONTH, seq8(), '2022-01-01') AS DTE
    FROM TABLE(generator(rowcount => 24)) -- Generates dates from 01/2022 to 12/2023
);

-- Generate 100m customer IDs
CREATE OR REPLACE TEMPORARY TABLE CUSTOMER_SYNTHETIC_DATA.CLTV.SYNTHETIC_CUSTOMED_ID AS (
    SELECT ROW_NUMBER() OVER (ORDER BY 1) AS cust_id
    FROM TABLE(generator(rowcount => 100000000))
);

-- Generate synthetic data for 100m customers with random CLTV value.
CREATE OR REPLACE TABLE CUSTOMER_SYNTHETIC_DATA.CLTV.CUSTOMER_CLTV AS (
    SELECT
        a.cust_id,
        b.DTE AS ts,
        ROUND(UNIFORM(15, 10000, RANDOM(1234)), 2) AS cltv
    FROM CUSTOMER_SYNTHETIC_DATA.CLTV.SYNTHETIC_CUSTOMED_ID a
    CROSS JOIN CUSTOMER_SYNTHETIC_DATA.CLTV.MONTH_DATE b
);

-- Check data (limiting to 100 rows)
SELECT * FROM CUSTOMER_SYNTHETIC_DATA.CLTV.CUSTOMER_CLTV LIMIT 100;

-- Count rows in the generated table. It should be equal to 24 x 100 million
SELECT COUNT(*) AS row_count FROM CUSTOMER_SYNTHETIC_DATA.CLTV.CUSTOMER_CLTV;