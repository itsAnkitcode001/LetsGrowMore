/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      computed1.DM1
 *
 * Date Created : Friday, May 31, 2024 15:54:29
 * Target DBMS : Databricks
 */

/* 
 * TABLE: Entity1 
 */

CREATE TABLE Entity1
(
    testA    string GENERATED ALWAYS AS ('abc'),
    testB    int GENERATED ALWAYS AS (1),
    testC    boolean GENERATED ALWAYS AS (true),
    testD    decimal(10, 0) GENERATED ALWAYS AS ((CAST(0 AS decimal(10, 0))))
)
;

