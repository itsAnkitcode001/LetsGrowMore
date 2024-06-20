/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      Students_Copy.DM1
 *
 * Date Created : Thursday, June 20, 2024 19:11:16
 * Target DBMS : Databricks
 */

/* 
 * TABLE: tbl_Students 
 */

CREATE TABLE tbl_Students
(
    StudentId       int         NOT NULL,
    Firstname       string,
    Lastname        string      NOT NULL,
    Email           string      NOT NULL,
    DOB             date        NOT NULL,
    AverageScore    int,
    Address         array<struct<
        Country    string      NOT NULL,
        City       string      NOT NULL,
        CAP        int         NOT NULL
    >>,
    PRIMARY KEY (StudentId) 
)
;

