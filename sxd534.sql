/*
 * ER/Studio Data Architect SQL Code Generation
 *
 * Date Created : Friday, June 07, 2024 16:33:11
 * Target DBMS : Databricks
 */

/*
 * ER/Studio Data Architect SQL Code Generation
 *
 * Date Created : Friday, June 07, 2024 16:33:11
 * Target DBMS : Databricks
 */

/* 
 * VIEW: StudentsAddress 
 */

CREATE VIEW StudentsAddress 
(StudentId,  Firstname)
 AS
SELECT tb.StudentId StudentId, tb.Firstname Firstname
FROM tbl_Students tb
;


