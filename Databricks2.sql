/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      Students_Copy.DM1
 *
 * Date Created : Friday, June 07, 2024 10:24:13
 * Target DBMS : Google BigQuery
 */

/* 
 * TABLE: tbl_Students 
 */

CREATE TABLE tbl_Students(
    StudentId         INTEGER       NOT NULL,
    Firstname         STRING(18),
    Lastname          STRING(18)    NOT NULL,
    Email             STRING(18)    NOT NULL,
    DOB               DATE          NOT NULL,
    AverageScore      INTEGER,
    gstest_Address    STRUCT<
        Country    STRING(18)    NOT NULL,
        City       STRING(18)    NOT NULL,
        CAP        INTEGER       NOT NULL
    >
)
OPTIONS( 
    friendly_name = "tbl_Students"
)
;

/* 
 * TABLE: Test 
 */

CREATE TABLE Test(
    col1    STRING(18),
    col2    STRING(18),
    col3    STRING(18)
)
OPTIONS( 
    friendly_name = "Entity1"
)
;

