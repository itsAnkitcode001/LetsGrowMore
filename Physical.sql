/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      MaskTestIssue.DM1
 *
 * Date Created : Friday, May 31, 2024 18:32:40
 * Target DBMS : Databricks
 */

CREATE TABLE a.person
(
    PersonID     int         NOT NULL,
    Firstname    string,
    Lastname     string      NOT NULL,
    Email        string      NOT NULL,
    DOB          date,
    Score        int,
    ssn          string,
    Address      array<struct<
        Country    string,
        City       string,
        CAP        int
    >>,
    CONSTRAINT personindex PRIMARY KEY (PersonID) NOT ENFORCED DEFERRABLE 
)
;

