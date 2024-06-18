/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      testsample.DM1
 *
 * Date Created : Tuesday, June 18, 2024 22:33:01
 * Target DBMS : Google BigQuery
 */

/* 
 * TABLE: car 
 */

CREATE TABLE car(
    id         STRING(10)    NOT NULL,
    model      STRING(10),
    carname    STRING(10)
)
OPTIONS( 
    friendly_name = "car"
)
;

/* 
 * TABLE: library 
 */

CREATE TABLE library(
    l1            INTEGER              NOT NULL,
    roomnumber    BIGNUMERIC(10, 0),
    name          STRING(10),
    book          ARRAY<STRUCT<
        subject    STRING(10)    NOT NULL,
        b1int      INTEGER,
        name       STRING(10),
        pages      ARRAY<STRUCT<
            pagenumber    INTEGER       NOT NULL,
            content       STRING(18)
        >>
    >>
)
OPTIONS( 
    friendly_name = "library"
)
;

/* 
 * TABLE: ParentDomain 
 */

CREATE TABLE ParentDomain(
    domaincol      INTEGER       NOT NULL,
    colvarchar     STRING(10),
    ChildDomain    ARRAY<STRUCT<
        primarycol    STRING(10)    NOT NULL
    >>
)
OPTIONS( 
    friendly_name = "ParentDomain"
)
;

/* 
 * TABLE: random 
 */

CREATE TABLE random(
    pp1char    STRING(10)    NOT NULL
)
OPTIONS( 
    friendly_name = "random"
)
;

/* 
 * TABLE: service 
 */

CREATE TABLE service(
    serviceid    STRING(10)    NOT NULL,
    location     STRING(10),
    center       STRING(10),
    id           STRING(10)
)
OPTIONS( 
    friendly_name = "service"
)
;

/* 
 * TABLE: test1 
 */

CREATE TABLE test1(
    p1identity    INTEGER       NOT NULL,
    col1char      STRING(10)    NOT NULL,
    col2char      STRING(10),
    computed      FLOAT64
)
OPTIONS( 
    friendly_name = "test1"
)
;

/* 
 * TABLE: test2 
 */

CREATE TABLE test2(
    p2            STRING(10)    NOT NULL,
    col3char      STRING(10),
    col4char      STRING(10),
    p1identity    INTEGER       NOT NULL
)
OPTIONS( 
    friendly_name = "test2"
)
;

/* 
 * TABLE: test3 
 */

CREATE TABLE test3(
    p2    STRING(10)    NOT NULL
)
OPTIONS( 
    friendly_name = "test3"
)
;

