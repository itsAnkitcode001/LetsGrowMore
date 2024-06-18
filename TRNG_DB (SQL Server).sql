/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      HRMODEL_1.dm1
 *
 * Date Created : Tuesday, June 18, 2024 18:15:31
 * Target DBMS : Microsoft SQL Server 2017
 */

/* 
 * TABLE: ADR 
 */

CREATE TABLE ADR(
    ADR_ID      char(10)    NOT NULL,
    ADR_LN_1    char(10)    NULL,
    ADR_LN_2    char(10)    NULL,
    CTY         char(10)    NULL,
    PST_CDE     char(10)    NULL,
    CTY_1       char(10)    NULL,
    PRIMARY KEY NONCLUSTERED (ADR_ID)
)

go


IF OBJECT_ID('ADR') IS NOT NULL
    PRINT '<<< CREATED TABLE ADR >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ADR >>>'
go

/* 
 * TABLE: AGY 
 */

CREATE TABLE AGY(
    ID          int              IDENTITY(1,1),
    AGYNME      varchar(10)      NULL,
    MAINCCT     varchar(100)     NULL,
    CONTRACT    varchar(1000)    NULL,
    PRIMARY KEY NONCLUSTERED (ID)
)

go


IF OBJECT_ID('AGY') IS NOT NULL
    PRINT '<<< CREATED TABLE AGY >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE AGY >>>'
go

/* 
 * TABLE: CNR 
 */

CREATE TABLE CNR(
    EMPNMB      varchar(12)      NOT NULL,
    DAYRAT      numeric(7, 0)    NULL,
    AGENCYID    int              NOT NULL,
    PRIMARY KEY NONCLUSTERED (EMPNMB)
)

go


IF OBJECT_ID('CNR') IS NOT NULL
    PRINT '<<< CREATED TABLE CNR >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CNR >>>'
go

/* 
 * TABLE: DEP 
 */

CREATE TABLE DEP(
    ID     char(10)    NOT NULL,
    NME    char(10)    NULL,
    PRIMARY KEY NONCLUSTERED (ID)
)

go


IF OBJECT_ID('DEP') IS NOT NULL
    PRINT '<<< CREATED TABLE DEP >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DEP >>>'
go

/* 
 * TABLE: EMP 
 */

CREATE TABLE EMP(
    EMPNMB      varchar(12)       NOT NULL,
    EMPTYP      char(1)           NOT NULL,
    STTDTE      date              NULL,
    PHONENMB    numeric(15, 0)    NULL,
    FRSNME      varchar(200)      NOT NULL,
    SURNAME     varchar(200)      NOT NULL,
    MEMBER      char(10)          NOT NULL,
    MANAGER     char(10)          NULL,
    ADR_ID      char(10)          NOT NULL,
    PRIMARY KEY NONCLUSTERED (EMPNMB)
)

go


IF OBJECT_ID('EMP') IS NOT NULL
    PRINT '<<< CREATED TABLE EMP >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE EMP >>>'
go

/* 
 * TABLE: EMPSKLMTX 
 */

CREATE TABLE EMPSKLMTX(
    ID        char(10)       NOT NULL,
    EMPNMB    varchar(12)    NOT NULL,
    LVL       char(10)       NULL,
    PRIMARY KEY NONCLUSTERED (ID, EMPNMB)
)

go


IF OBJECT_ID('EMPSKLMTX') IS NOT NULL
    PRINT '<<< CREATED TABLE EMPSKLMTX >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE EMPSKLMTX >>>'
go

/* 
 * TABLE: FULL_TIMEEMP 
 */

CREATE TABLE FULL_TIMEEMP(
    EMPNMB     varchar(12)    NOT NULL,
    SALARY     money          NULL,
    VCTDAYS    int            NULL,
    PRIMARY KEY NONCLUSTERED (EMPNMB)
)

go


IF OBJECT_ID('FULL_TIMEEMP') IS NOT NULL
    PRINT '<<< CREATED TABLE FULL_TIMEEMP >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE FULL_TIMEEMP >>>'
go

/* 
 * TABLE: SKL 
 */

CREATE TABLE SKL(
    ID     char(10)    NOT NULL,
    NME    char(10)    NOT NULL,
    DSP    char(10)    NULL,
    CTY    char(10)    NULL,
    PRIMARY KEY NONCLUSTERED (ID)
)

go


IF OBJECT_ID('SKL') IS NOT NULL
    PRINT '<<< CREATED TABLE SKL >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SKL >>>'
go

/* 
 * TABLE: SKLTRGCRS 
 */

CREATE TABLE SKLTRGCRS(
    ID       char(10)    NOT NULL,
    CRSID    char(10)    NOT NULL,
    PRIMARY KEY NONCLUSTERED (ID, CRSID)
)

go


IF OBJECT_ID('SKLTRGCRS') IS NOT NULL
    PRINT '<<< CREATED TABLE SKLTRGCRS >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SKLTRGCRS >>>'
go

/* 
 * TABLE: TRGCRS 
 */

CREATE TABLE TRGCRS(
    CRSID       char(10)    NOT NULL,
    TITLE       char(10)    NULL,
    SYNOPSIS    char(10)    NULL,
    PRIMARY KEY NONCLUSTERED (CRSID)
)

go


IF OBJECT_ID('TRGCRS') IS NOT NULL
    PRINT '<<< CREATED TABLE TRGCRS >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TRGCRS >>>'
go

/* 
 * TABLE: TRGHST 
 */

CREATE TABLE TRGHST(
    EMPNMB           varchar(12)    NOT NULL,
    CRSID            char(10)       NOT NULL,
    COMPLETIONDTE    char(10)       NULL,
    RESULT           char(10)       NULL,
    PRIMARY KEY NONCLUSTERED (EMPNMB, CRSID)
)

go


IF OBJECT_ID('TRGHST') IS NOT NULL
    PRINT '<<< CREATED TABLE TRGHST >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TRGHST >>>'
go

