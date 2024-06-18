/*
 * ER/Studio Data Architect SQL Code Generation
 * Company :      IDERA
 * Project :      ADV_1933_1.dm1
 * Author :       Product Management
 *
 * Date Created : Tuesday, June 18, 2024 12:10:18
 * Target DBMS : Microsoft SQL Server 2005
 */

CREATE TYPE AccountNumber FROM nvarchar(15) NULL
go

CREATE TYPE Flag FROM bit NOT NULL
go

CREATE TYPE Name FROM nvarchar(50) NULL
go

CREATE TYPE NameStyle FROM bit NOT NULL
go

CREATE TYPE OrderNumber FROM nvarchar(25) NULL
go

CREATE TYPE Phone FROM nvarchar(25) NULL
go

/* 
 * TABLE: Address 
 */

CREATE TABLE Address(
    AddressID          int                 IDENTITY(1,1) NOT FOR REPLICATION,
    AddressLine1       nvarchar(60)        NOT NULL,
    AddressLine2       nvarchar(60)        NULL,
    City               nvarchar(30)        NOT NULL,
    StateProvinceID    int                 NOT NULL,
    PostalCode         nvarchar(15)        NOT NULL,
    rowguid            uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_Address_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate       datetime            CONSTRAINT [DF_Address_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (AddressID)
)

go


IF OBJECT_ID('Address') IS NOT NULL
    PRINT '<<< CREATED TABLE Address >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Address >>>'
go

/* 
 * TABLE: AddressType 
 */

CREATE TABLE AddressType(
    AddressTypeID    int                 IDENTITY(1,1),
    Name             Name                NOT NULL,
    rowguid          uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_AddressType_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate     datetime            CONSTRAINT [DF_AddressType_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (AddressTypeID)
)

go


IF OBJECT_ID('AddressType') IS NOT NULL
    PRINT '<<< CREATED TABLE AddressType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE AddressType >>>'
go

/* 
 * TABLE: AWBuildVersion 
 */

CREATE TABLE AWBuildVersion(
    SystemInformationID    tinyint         IDENTITY(1,1),
    [Database Version]     nvarchar(25)    NOT NULL,
    VersionDate            datetime        NOT NULL,
    ModifiedDate           datetime        CONSTRAINT [DF_AWBuildVersion_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (SystemInformationID)
)

go


IF OBJECT_ID('AWBuildVersion') IS NOT NULL
    PRINT '<<< CREATED TABLE AWBuildVersion >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE AWBuildVersion >>>'
go

/* 
 * TABLE: BillOfMaterials 
 */

CREATE TABLE BillOfMaterials(
    BillOfMaterialsID    int              IDENTITY(1,1),
    ProductAssemblyID    int              NULL,
    ComponentID          int              NOT NULL,
    StartDate            datetime         CONSTRAINT [DF_BillOfMaterials_StartDate] DEFAULT (getdate()) NOT NULL,
    EndDate              datetime         NULL,
    UnitMeasureCode      nchar(3)         NOT NULL,
    BOMLevel             smallint         NOT NULL,
    PerAssemblyQty       decimal(8, 2)    CONSTRAINT [DF_BillOfMaterials_PerAssemblyQty] DEFAULT (1.00) NOT NULL
                         CONSTRAINT CK_BillOfMaterials_PerAssemblyQty CHECK (([PerAssemblyQty]>=(1.00))),
    ModifiedDate         datetime         CONSTRAINT [DF_BillOfMaterials_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY NONCLUSTERED (BillOfMaterialsID)
)

go


IF OBJECT_ID('BillOfMaterials') IS NOT NULL
    PRINT '<<< CREATED TABLE BillOfMaterials >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE BillOfMaterials >>>'
go

/* 
 * TABLE: Contact 
 */

CREATE TABLE Contact(
    ContactID                int                 IDENTITY(1,1) NOT FOR REPLICATION,
    NameStyle                NameStyle           CONSTRAINT [DF_Contact_NameStyle] DEFAULT ((0)) NOT NULL,
    Title                    nvarchar(8)         NULL,
    FirstName                Name                NOT NULL,
    MiddleName               Name                NULL,
    LastName                 Name                NOT NULL,
    Suffix                   nvarchar(10)        NULL,
    EmailAddress             nvarchar(50)        NULL,
    EmailPromotion           int                 CONSTRAINT [DF_Contact_EmailPromotion] DEFAULT (0) NOT NULL
                             CONSTRAINT CK_Contact_EmailPromotion CHECK (([EmailPromotion]>=(0) AND [EmailPromotion]<=(2))),
    Phone                    Phone               NULL,
    PasswordHash             varchar(40)         NOT NULL,
    PasswordSalt             varchar(10)         NOT NULL,
    AdditionalContactInfo    xml                 (CONTENT Person.AdditionalContactInfoSchemaCollection) NULL,
    rowguid                  uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_Contact_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate             datetime            CONSTRAINT [DF_Contact_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ContactID)
)

go


IF OBJECT_ID('Contact') IS NOT NULL
    PRINT '<<< CREATED TABLE Contact >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Contact >>>'
go

/* 
 * TABLE: ContactCreditCard 
 */

CREATE TABLE ContactCreditCard(
    ContactID       int         NOT NULL,
    CreditCardID    int         NOT NULL,
    ModifiedDate    datetime    CONSTRAINT [DF_ContactCreditCard_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ContactID, CreditCardID)
)

go


IF OBJECT_ID('ContactCreditCard') IS NOT NULL
    PRINT '<<< CREATED TABLE ContactCreditCard >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ContactCreditCard >>>'
go

/* 
 * TABLE: ContactType 
 */

CREATE TABLE ContactType(
    ContactTypeID    int         IDENTITY(1,1),
    Name             Name        NOT NULL,
    ModifiedDate     datetime    CONSTRAINT [DF_ContactType_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ContactTypeID)
)

go


IF OBJECT_ID('ContactType') IS NOT NULL
    PRINT '<<< CREATED TABLE ContactType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ContactType >>>'
go

/* 
 * TABLE: CountryRegion 
 */

CREATE TABLE CountryRegion(
    CountryRegionCode    nvarchar(3)    NOT NULL,
    Name                 Name           NOT NULL,
    ModifiedDate         datetime       CONSTRAINT [DF_CountryRegion_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (CountryRegionCode)
)

go


IF OBJECT_ID('CountryRegion') IS NOT NULL
    PRINT '<<< CREATED TABLE CountryRegion >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CountryRegion >>>'
go

/* 
 * TABLE: CountryRegionCurrency 
 */

CREATE TABLE CountryRegionCurrency(
    CountryRegionCode    nvarchar(3)    NOT NULL,
    CurrencyCode         nchar(3)       NOT NULL,
    ModifiedDate         datetime       CONSTRAINT [DF_CountryRegionCurrency_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (CountryRegionCode, CurrencyCode)
)

go


IF OBJECT_ID('CountryRegionCurrency') IS NOT NULL
    PRINT '<<< CREATED TABLE CountryRegionCurrency >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CountryRegionCurrency >>>'
go

/* 
 * TABLE: CreditCard 
 */

CREATE TABLE CreditCard(
    CreditCardID    int             IDENTITY(1,1),
    CardType        nvarchar(50)    NOT NULL,
    CardNumber      nvarchar(25)    NOT NULL,
    ExpMonth        tinyint         NOT NULL,
    ExpYear         smallint        NOT NULL,
    ModifiedDate    datetime        CONSTRAINT [DF_CreditCard_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (CreditCardID)
)

go


IF OBJECT_ID('CreditCard') IS NOT NULL
    PRINT '<<< CREATED TABLE CreditCard >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CreditCard >>>'
go

/* 
 * TABLE: Culture 
 */

CREATE TABLE Culture(
    CultureID       nchar(6)    NOT NULL,
    Name            Name        NOT NULL,
    ModifiedDate    datetime    CONSTRAINT [DF_Culture_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (CultureID)
)

go


IF OBJECT_ID('Culture') IS NOT NULL
    PRINT '<<< CREATED TABLE Culture >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Culture >>>'
go

/* 
 * TABLE: Currency 
 */

CREATE TABLE Currency(
    CurrencyCode    nchar(3)    NOT NULL,
    Name            Name        NOT NULL,
    ModifiedDate    datetime    CONSTRAINT [DF_Currency_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (CurrencyCode)
)

go


IF OBJECT_ID('Currency') IS NOT NULL
    PRINT '<<< CREATED TABLE Currency >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Currency >>>'
go

/* 
 * TABLE: CurrencyRate 
 */

CREATE TABLE CurrencyRate(
    CurrencyRateID      int         IDENTITY(1,1),
    CurrencyRateDate    datetime    NOT NULL,
    FromCurrencyCode    nchar(3)    NOT NULL,
    ToCurrencyCode      nchar(3)    NOT NULL,
    AverageRate         money       NOT NULL,
    EndOfDayRate        money       NOT NULL,
    ModifiedDate        datetime    CONSTRAINT [DF_CurrencyRate_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (CurrencyRateID)
)

go


IF OBJECT_ID('CurrencyRate') IS NOT NULL
    PRINT '<<< CREATED TABLE CurrencyRate >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CurrencyRate >>>'
go

/* 
 * TABLE: Customer 
 */

CREATE TABLE Customer(
    CustomerID       int                 IDENTITY(1,1) NOT FOR REPLICATION,
    TerritoryID      int                 NULL,
    AccountNumber    varchar(10)         NOT NULL,
    CustomerType     nchar(1)            NOT NULL
                     CONSTRAINT CK_Customer_CustomerType CHECK ((upper([CustomerType])='I' OR upper([CustomerType])='S')),
    rowguid          uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_Customer_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate     datetime            CONSTRAINT [DF_Customer_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (CustomerID)
)

go


IF OBJECT_ID('Customer') IS NOT NULL
    PRINT '<<< CREATED TABLE Customer >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Customer >>>'
go

/* 
 * TABLE: CustomerAddress 
 */

CREATE TABLE CustomerAddress(
    CustomerID       int                 NOT NULL,
    AddressID        int                 NOT NULL,
    AddressTypeID    int                 NOT NULL,
    rowguid          uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_CustomerAddress_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate     datetime            CONSTRAINT [DF_CustomerAddress_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (CustomerID, AddressID)
)

go


IF OBJECT_ID('CustomerAddress') IS NOT NULL
    PRINT '<<< CREATED TABLE CustomerAddress >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE CustomerAddress >>>'
go

/* 
 * TABLE: Department 
 */

CREATE TABLE Department(
    DepartmentID    smallint    IDENTITY(1,1),
    Name            Name        NOT NULL,
    GroupName       Name        NOT NULL,
    ModifiedDate    datetime    CONSTRAINT [DF_Department_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (DepartmentID)
)

go


IF OBJECT_ID('Department') IS NOT NULL
    PRINT '<<< CREATED TABLE Department >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Department >>>'
go

/* 
 * TABLE: Document 
 */

CREATE TABLE Document(
    DocumentID         int               IDENTITY(1,1),
    Title              nvarchar(50)      NOT NULL,
    FileName           nvarchar(400)     NOT NULL,
    FileExtension      nvarchar(8)       NOT NULL,
    Revision           nchar(5)          NOT NULL,
    ChangeNumber       int               CONSTRAINT [DF_Document_ChangeNumber] DEFAULT (0) NOT NULL,
    Status             tinyint           NOT NULL
                       CONSTRAINT CK_Document_Status CHECK (([Status]>=(1) AND [Status]<=(3))),
    DocumentSummary    nvarchar(max)     NULL,
    Document           varbinary(max)    NULL,
    ModifiedDate       datetime          CONSTRAINT [DF_Document_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (DocumentID)
)

go


IF OBJECT_ID('Document') IS NOT NULL
    PRINT '<<< CREATED TABLE Document >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Document >>>'
go

/* 
 * TABLE: Employee 
 */

CREATE TABLE Employee(
    EmployeeID                   int                 IDENTITY(1,1),
    NationalIDNumber             nvarchar(15)        NOT NULL,
    ContactID                    int                 NOT NULL,
    LoginID                      nvarchar(256)       NOT NULL,
    ManagerID                    int                 NULL,
    Title                        nvarchar(50)        NOT NULL,
    BirthDate                    datetime            NOT NULL
                                 CONSTRAINT CK_Employee_BirthDate CHECK (([BirthDate]>='1930-01-01' AND [BirthDate]<=dateadd(year,(-18),getdate()))),
    MaritalStatus                nchar(1)            NOT NULL
                                 CONSTRAINT CK_Employee_MaritalStatus CHECK ((upper([MaritalStatus])='S' OR upper([MaritalStatus])='M')),
    Gender                       nchar(1)            NOT NULL
                                 CONSTRAINT CK_Employee_Gender CHECK ((upper([Gender])='F' OR upper([Gender])='M')),
    HireDate                     datetime            NOT NULL
                                 CONSTRAINT CK_Employee_HireDate CHECK (([HireDate]>='1996-07-01' AND [HireDate]<=dateadd(day,(1),getdate()))),
    SalariedFlag                 Flag                CONSTRAINT [DF_Employee_SalariedFlag] DEFAULT ((1)) NOT NULL,
    VacationHours                smallint            CONSTRAINT [DF_Employee_VacationHours] DEFAULT (0) NOT NULL
                                 CONSTRAINT CK_Employee_VacationHours CHECK (([VacationHours]>=(-40) AND [VacationHours]<=(240))),
    SickLeaveHours               smallint            CONSTRAINT [DF_Employee_SickLeaveHours] DEFAULT (0) NOT NULL
                                 CONSTRAINT CK_Employee_SickLeaveHours CHECK (([SickLeaveHours]>=(0) AND [SickLeaveHours]<=(120))),
    CurrentFlag                  Flag                CONSTRAINT [DF_Employee_CurrentFlag] DEFAULT ((1)) NOT NULL,
    rowguid                      uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_Employee_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate                 datetime            CONSTRAINT [DF_Employee_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    EncryptedNationalIDNumber    varbinary(128)      NULL,
    PRIMARY KEY CLUSTERED (EmployeeID)
)

go


IF OBJECT_ID('Employee') IS NOT NULL
    PRINT '<<< CREATED TABLE Employee >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Employee >>>'
go

/* 
 * TABLE: EmployeeAddress 
 */

CREATE TABLE EmployeeAddress(
    EmployeeID      int                 NOT NULL,
    AddressID       int                 NOT NULL,
    rowguid         uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_EmployeeAddress_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate    datetime            CONSTRAINT [DF_EmployeeAddress_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (EmployeeID, AddressID)
)

go


IF OBJECT_ID('EmployeeAddress') IS NOT NULL
    PRINT '<<< CREATED TABLE EmployeeAddress >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE EmployeeAddress >>>'
go

/* 
 * TABLE: EmployeeDepartmentHistory 
 */

CREATE TABLE EmployeeDepartmentHistory(
    EmployeeID      int         NOT NULL,
    DepartmentID    smallint    NOT NULL,
    ShiftID         tinyint     NOT NULL,
    StartDate       datetime    NOT NULL,
    EndDate         datetime    NULL,
    ModifiedDate    datetime    CONSTRAINT [DF_EmployeeDepartmentHistory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (EmployeeID, StartDate, DepartmentID, ShiftID)
)

go


IF OBJECT_ID('EmployeeDepartmentHistory') IS NOT NULL
    PRINT '<<< CREATED TABLE EmployeeDepartmentHistory >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE EmployeeDepartmentHistory >>>'
go

/* 
 * TABLE: EmployeePayHistory 
 */

CREATE TABLE EmployeePayHistory(
    EmployeeID        int         NOT NULL,
    RateChangeDate    datetime    NOT NULL,
    Rate              money       NOT NULL
                      CONSTRAINT CK_EmployeePayHistory_Rate CHECK (([Rate]>=(6.50) AND [Rate]<=(200.00))),
    PayFrequency      tinyint     NOT NULL
                      CONSTRAINT CK_EmployeePayHistory_PayFrequency CHECK (([PayFrequency]=(2) OR [PayFrequency]=(1))),
    ModifiedDate      datetime    CONSTRAINT [DF_EmployeePayHistory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (EmployeeID, RateChangeDate)
)

go


IF OBJECT_ID('EmployeePayHistory') IS NOT NULL
    PRINT '<<< CREATED TABLE EmployeePayHistory >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE EmployeePayHistory >>>'
go

/* 
 * TABLE: Entity1 
 */

CREATE TABLE Entity1(

)

go


IF OBJECT_ID('Entity1') IS NOT NULL
    PRINT '<<< CREATED TABLE Entity1 >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Entity1 >>>'
go

/* 
 * TABLE: Entity2 
 */

CREATE TABLE Entity2(

)

go


IF OBJECT_ID('Entity2') IS NOT NULL
    PRINT '<<< CREATED TABLE Entity2 >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Entity2 >>>'
go

/* 
 * TABLE: ErrorLog 
 */

CREATE TABLE ErrorLog(
    ErrorLogID        int               IDENTITY(1,1),
    ErrorTime         datetime          CONSTRAINT [DF_ErrorLog_ErrorTime] DEFAULT (getdate()) NOT NULL,
    UserName          char(10)          NOT NULL,
    ErrorNumber       int               NOT NULL,
    ErrorSeverity     int               NULL,
    ErrorState        int               NULL,
    ErrorProcedure    nvarchar(126)     NULL,
    ErrorLine         int               NULL,
    ErrorMessage      nvarchar(4000)    NOT NULL,
    PRIMARY KEY CLUSTERED (ErrorLogID)
)

go


IF OBJECT_ID('ErrorLog') IS NOT NULL
    PRINT '<<< CREATED TABLE ErrorLog >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ErrorLog >>>'
go

/* 
 * TABLE: Illustration 
 */

CREATE TABLE Illustration(
    IllustrationID    int         IDENTITY(1,1),
    Diagram           xml         NULL,
    ModifiedDate      datetime    CONSTRAINT [DF_Illustration_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (IllustrationID)
)

go


IF OBJECT_ID('Illustration') IS NOT NULL
    PRINT '<<< CREATED TABLE Illustration >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Illustration >>>'
go

/* 
 * TABLE: Individual 
 */

CREATE TABLE Individual(
    CustomerID      int         NOT NULL,
    ContactID       int         NOT NULL,
    Demographics    xml         (CONTENT Sales.IndividualSurveySchemaCollection) NULL,
    ModifiedDate    datetime    CONSTRAINT [DF_Individual_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (CustomerID)
)

go


IF OBJECT_ID('Individual') IS NOT NULL
    PRINT '<<< CREATED TABLE Individual >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Individual >>>'
go

/* 
 * TABLE: JobCandidate 
 */

CREATE TABLE JobCandidate(
    JobCandidateID    int         IDENTITY(1,1),
    EmployeeID        int         NULL,
    Resume            xml         (CONTENT HumanResources.HRResumeSchemaCollection) NULL,
    ModifiedDate      datetime    CONSTRAINT [DF_JobCandidate_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (JobCandidateID)
)

go


IF OBJECT_ID('JobCandidate') IS NOT NULL
    PRINT '<<< CREATED TABLE JobCandidate >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE JobCandidate >>>'
go

/* 
 * TABLE: Location 
 */

CREATE TABLE Location(
    LocationID      smallint         IDENTITY(1,1),
    Name            Name             NOT NULL,
    CostRate        smallmoney       CONSTRAINT [DF_Location_CostRate] DEFAULT ((0.00)) NOT NULL
                    CONSTRAINT CK_Location_CostRate CHECK (([CostRate]>=(0.00))),
    Availability    decimal(8, 2)    CONSTRAINT [DF_Location_Availability] DEFAULT (0.00) NOT NULL
                    CONSTRAINT CK_Location_Availability CHECK (([Availability]>=(0.00))),
    ModifiedDate    datetime         CONSTRAINT [DF_Location_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (LocationID)
)

go


IF OBJECT_ID('Location') IS NOT NULL
    PRINT '<<< CREATED TABLE Location >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Location >>>'
go

/* 
 * TABLE: Product 
 */

CREATE TABLE Product(
    ProductID                int                 IDENTITY(1,1),
    Name                     Name                NOT NULL,
    ProductNumber            nvarchar(25)        NOT NULL,
    MakeFlag                 Flag                CONSTRAINT [DF_Product_MakeFlag] DEFAULT ((1)) NOT NULL,
    FinishedGoodsFlag        Flag                CONSTRAINT [DF_Product_FinishedGoodsFlag] DEFAULT ((1)) NOT NULL,
    Color                    nvarchar(15)        NULL,
    SafetyStockLevel         smallint            NOT NULL
                             CONSTRAINT CK_Product_SafetyStockLevel CHECK (([SafetyStockLevel]>(0))),
    ReorderPoint             smallint            NOT NULL
                             CONSTRAINT CK_Product_ReorderPoint CHECK (([ReorderPoint]>(0))),
    StandardCost             money               NOT NULL
                             CONSTRAINT CK_Product_StandardCost CHECK (([StandardCost]>=(0.00))),
    ListPrice                money               NOT NULL
                             CONSTRAINT CK_Product_ListPrice CHECK (([ListPrice]>=(0.00))),
    Size                     nvarchar(5)         NULL,
    SizeUnitMeasureCode      nchar(3)            NULL,
    WeightUnitMeasureCode    nchar(3)            NULL,
    Weight                   decimal(8, 2)       NULL
                             CONSTRAINT CK_Product_Weight CHECK (([Weight]>(0.00))),
    DaysToManufacture        int                 NOT NULL
                             CONSTRAINT CK_Product_DaysToManufacture CHECK (([DaysToManufacture]>=(0))),
    ProductLine              nchar(2)            NULL
                             CONSTRAINT CK_Product_ProductLine CHECK ((upper([ProductLine])='R' OR upper([ProductLine])='M' OR upper([ProductLine])='T' OR upper([ProductLine])='S' OR [ProductLine] IS NULL)),
    Class                    nchar(2)            NULL
                             CONSTRAINT CK_Product_Class CHECK ((upper([Class])='H' OR upper([Class])='M' OR upper([Class])='L' OR [Class] IS NULL)),
    Style                    nchar(2)            NULL
                             CONSTRAINT CK_Product_Style CHECK ((upper([Style])='U' OR upper([Style])='M' OR upper([Style])='W' OR [Style] IS NULL)),
    ProductSubcategoryID     int                 NULL,
    ProductModelID           int                 NULL,
    SellStartDate            datetime            NOT NULL,
    SellEndDate              datetime            NULL,
    DiscontinuedDate         datetime            NULL,
    rowguid                  uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_Product_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate             datetime            CONSTRAINT [DF_Product_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ProductID)
)

go


IF OBJECT_ID('Product') IS NOT NULL
    PRINT '<<< CREATED TABLE Product >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Product >>>'
go

/* 
 * TABLE: ProductCategory 
 */

CREATE TABLE ProductCategory(
    ProductCategoryID    int                 IDENTITY(1,1),
    Name                 Name                NOT NULL,
    rowguid              uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_ProductCategory_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate         datetime            CONSTRAINT [DF_ProductCategory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ProductCategoryID)
)

go


IF OBJECT_ID('ProductCategory') IS NOT NULL
    PRINT '<<< CREATED TABLE ProductCategory >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ProductCategory >>>'
go

/* 
 * TABLE: ProductCostHistory 
 */

CREATE TABLE ProductCostHistory(
    ProductID       int         NOT NULL,
    StartDate       datetime    NOT NULL,
    EndDate         datetime    NULL,
    StandardCost    money       NOT NULL
                    CONSTRAINT CK_ProductCostHistory_StandardCost CHECK (([StandardCost]>=(0.00))),
    ModifiedDate    datetime    CONSTRAINT [DF_ProductCostHistory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ProductID, StartDate)
)

go


IF OBJECT_ID('ProductCostHistory') IS NOT NULL
    PRINT '<<< CREATED TABLE ProductCostHistory >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ProductCostHistory >>>'
go

/* 
 * TABLE: ProductDescription 
 */

CREATE TABLE ProductDescription(
    ProductDescriptionID    int                 IDENTITY(1,1),
    Description             nvarchar(400)       NOT NULL,
    rowguid                 uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_ProductDescription_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate            datetime            CONSTRAINT [DF_ProductDescription_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ProductDescriptionID)
)

go


IF OBJECT_ID('ProductDescription') IS NOT NULL
    PRINT '<<< CREATED TABLE ProductDescription >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ProductDescription >>>'
go

/* 
 * TABLE: ProductDocument 
 */

CREATE TABLE ProductDocument(
    ProductID       int         NOT NULL,
    DocumentID      int         NOT NULL,
    ModifiedDate    datetime    CONSTRAINT [DF_ProductDocument_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ProductID, DocumentID)
)

go


IF OBJECT_ID('ProductDocument') IS NOT NULL
    PRINT '<<< CREATED TABLE ProductDocument >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ProductDocument >>>'
go

/* 
 * TABLE: ProductInventory 
 */

CREATE TABLE ProductInventory(
    ProductID       int                 NOT NULL,
    LocationID      smallint            NOT NULL,
    Shelf           nvarchar(10)        NOT NULL
                    CONSTRAINT CK_ProductInventory_Shelf CHECK (([Shelf] like '[A-Za-z]' OR [Shelf]='N/A')),
    Bin             tinyint             NOT NULL
                    CONSTRAINT CK_ProductInventory_Bin CHECK (([Bin]>=(0) AND [Bin]<=(100))),
    Quantity        smallint            CONSTRAINT [DF_ProductInventory_Quantity] DEFAULT (0) NOT NULL,
    rowguid         uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_ProductInventory_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate    datetime            CONSTRAINT [DF_ProductInventory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ProductID, LocationID)
)

go


IF OBJECT_ID('ProductInventory') IS NOT NULL
    PRINT '<<< CREATED TABLE ProductInventory >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ProductInventory >>>'
go

/* 
 * TABLE: ProductListPriceHistory 
 */

CREATE TABLE ProductListPriceHistory(
    ProductID       int         NOT NULL,
    StartDate       datetime    NOT NULL,
    EndDate         datetime    NULL,
    ListPrice       money       NOT NULL
                    CONSTRAINT CK_ProductListPriceHistory_ListPrice CHECK (([ListPrice]>(0.00))),
    ModifiedDate    datetime    CONSTRAINT [DF_ProductListPriceHistory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ProductID, StartDate)
)

go


IF OBJECT_ID('ProductListPriceHistory') IS NOT NULL
    PRINT '<<< CREATED TABLE ProductListPriceHistory >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ProductListPriceHistory >>>'
go

/* 
 * TABLE: ProductModel 
 */

CREATE TABLE ProductModel(
    ProductModelID        int                 IDENTITY(1,1),
    Name                  Name                NOT NULL,
    CatalogDescription    xml                 (CONTENT Production.ProductDescriptionSchemaCollection) NULL,
    Instructions          xml                 (CONTENT Production.ManuInstructionsSchemaCollection) NULL,
    rowguid               uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_ProductModel_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate          datetime            CONSTRAINT [DF_ProductModel_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ProductModelID)
)

go


IF OBJECT_ID('ProductModel') IS NOT NULL
    PRINT '<<< CREATED TABLE ProductModel >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ProductModel >>>'
go

/* 
 * TABLE: ProductModelIllustration 
 */

CREATE TABLE ProductModelIllustration(
    ProductModelID    int         NOT NULL,
    IllustrationID    int         NOT NULL,
    ModifiedDate      datetime    CONSTRAINT [DF_ProductModelIllustration_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ProductModelID, IllustrationID)
)

go


IF OBJECT_ID('ProductModelIllustration') IS NOT NULL
    PRINT '<<< CREATED TABLE ProductModelIllustration >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ProductModelIllustration >>>'
go

/* 
 * TABLE: ProductModelProductDescriptionCulture 
 */

CREATE TABLE ProductModelProductDescriptionCulture(
    ProductModelID          int         NOT NULL,
    ProductDescriptionID    int         NOT NULL,
    CultureID               nchar(6)    NOT NULL,
    ModifiedDate            datetime    CONSTRAINT [DF_ProductModelProductDescriptionCulture_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ProductModelID, ProductDescriptionID, CultureID)
)

go


IF OBJECT_ID('ProductModelProductDescriptionCulture') IS NOT NULL
    PRINT '<<< CREATED TABLE ProductModelProductDescriptionCulture >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ProductModelProductDescriptionCulture >>>'
go

/* 
 * TABLE: ProductPhoto 
 */

CREATE TABLE ProductPhoto(
    ProductPhotoID            int               IDENTITY(1,1),
    ThumbNailPhoto            varbinary(max)    NULL,
    ThumbnailPhotoFileName    nvarchar(50)      NULL,
    LargePhoto                varbinary(max)    NULL,
    LargePhotoFileName        nvarchar(50)      NULL,
    ModifiedDate              datetime          CONSTRAINT [DF_ProductPhoto_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ProductPhotoID)
)

go


IF OBJECT_ID('ProductPhoto') IS NOT NULL
    PRINT '<<< CREATED TABLE ProductPhoto >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ProductPhoto >>>'
go

/* 
 * TABLE: ProductProductPhoto 
 */

CREATE TABLE ProductProductPhoto(
    ProductID         int         NOT NULL,
    ProductPhotoID    int         NOT NULL,
    Primary           Flag        CONSTRAINT [DF_ProductProductPhoto_Primary] DEFAULT ((0)) NOT NULL,
    ModifiedDate      datetime    CONSTRAINT [DF_ProductProductPhoto_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY NONCLUSTERED (ProductID, ProductPhotoID)
)

go


IF OBJECT_ID('ProductProductPhoto') IS NOT NULL
    PRINT '<<< CREATED TABLE ProductProductPhoto >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ProductProductPhoto >>>'
go

/* 
 * TABLE: ProductReview 
 */

CREATE TABLE ProductReview(
    ProductReviewID    int               IDENTITY(1,1),
    ProductID          int               NOT NULL,
    ReviewerName       Name              NOT NULL,
    ReviewDate         datetime          CONSTRAINT [DF_ProductReview_ReviewDate] DEFAULT (getdate()) NOT NULL,
    EmailAddress       nvarchar(50)      NOT NULL,
    Rating             int               NOT NULL
                       CONSTRAINT CK_ProductReview_Rating CHECK (([Rating]>=(1) AND [Rating]<=(5))),
    Comments           nvarchar(3850)    NULL,
    ModifiedDate       datetime          CONSTRAINT [DF_ProductReview_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ProductReviewID)
)

go


IF OBJECT_ID('ProductReview') IS NOT NULL
    PRINT '<<< CREATED TABLE ProductReview >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ProductReview >>>'
go

/* 
 * TABLE: ProductSubcategory 
 */

CREATE TABLE ProductSubcategory(
    ProductSubcategoryID    int                 IDENTITY(1,1),
    ProductCategoryID       int                 NOT NULL,
    Name                    Name                NOT NULL,
    rowguid                 uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_ProductSubcategory_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate            datetime            CONSTRAINT [DF_ProductSubcategory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ProductSubcategoryID)
)

go


IF OBJECT_ID('ProductSubcategory') IS NOT NULL
    PRINT '<<< CREATED TABLE ProductSubcategory >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ProductSubcategory >>>'
go

/* 
 * TABLE: ProductVendor 
 */

CREATE TABLE ProductVendor(
    ProductID          int         NOT NULL,
    VendorID           int         NOT NULL,
    AverageLeadTime    int         NOT NULL
                       CONSTRAINT CK_ProductVendor_AverageLeadTime CHECK (([AverageLeadTime]>=(1))),
    StandardPrice      money       NOT NULL
                       CONSTRAINT CK_ProductVendor_StandardPrice CHECK (([StandardPrice]>(0.00))),
    LastReceiptCost    money       NULL
                       CONSTRAINT CK_ProductVendor_LastReceiptCost CHECK (([LastReceiptCost]>(0.00))),
    LastReceiptDate    datetime    NULL,
    MinOrderQty        int         NOT NULL
                       CONSTRAINT CK_ProductVendor_MinOrderQty CHECK (([MinOrderQty]>=(1))),
    MaxOrderQty        int         NOT NULL
                       CONSTRAINT CK_ProductVendor_MaxOrderQty CHECK (([MaxOrderQty]>=(1))),
    OnOrderQty         int         NULL
                       CONSTRAINT CK_ProductVendor_OnOrderQty CHECK (([OnOrderQty]>=(0))),
    UnitMeasureCode    nchar(3)    NOT NULL,
    ModifiedDate       datetime    CONSTRAINT [DF_ProductVendor_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ProductID, VendorID)
)

go


IF OBJECT_ID('ProductVendor') IS NOT NULL
    PRINT '<<< CREATED TABLE ProductVendor >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ProductVendor >>>'
go

/* 
 * TABLE: PurchaseOrderDetail 
 */

CREATE TABLE PurchaseOrderDetail(
    PurchaseOrderID          int              NOT NULL,
    PurchaseOrderDetailID    int              IDENTITY(1,1),
    DueDate                  datetime         NOT NULL,
    OrderQty                 smallint         NOT NULL
                             CONSTRAINT CK_PurchaseOrderDetail_OrderQty CHECK (([OrderQty]>(0))),
    ProductID                int              NOT NULL,
    UnitPrice                money            NOT NULL
                             CONSTRAINT CK_PurchaseOrderDetail_UnitPrice CHECK (([UnitPrice]>=(0.00))),
    LineTotal                money            NOT NULL,
    ReceivedQty              decimal(8, 2)    NOT NULL
                             CONSTRAINT CK_PurchaseOrderDetail_ReceivedQty CHECK (([ReceivedQty]>=(0.00))),
    RejectedQty              decimal(8, 2)    NOT NULL
                             CONSTRAINT CK_PurchaseOrderDetail_RejectedQty CHECK (([RejectedQty]>=(0.00))),
    StockedQty               decimal(9, 2)    NOT NULL,
    ModifiedDate             datetime         CONSTRAINT [DF_PurchaseOrderDetail_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (PurchaseOrderID, PurchaseOrderDetailID)
)

go


IF OBJECT_ID('PurchaseOrderDetail') IS NOT NULL
    PRINT '<<< CREATED TABLE PurchaseOrderDetail >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE PurchaseOrderDetail >>>'
go

/* 
 * TABLE: PurchaseOrderHeader 
 */

CREATE TABLE PurchaseOrderHeader(
    PurchaseOrderID    int         IDENTITY(1,1),
    RevisionNumber     tinyint     CONSTRAINT [DF_PurchaseOrderHeader_RevisionNumber] DEFAULT (0) NOT NULL,
    Status             tinyint     CONSTRAINT [DF_PurchaseOrderHeader_Status] DEFAULT (1) NOT NULL
                       CONSTRAINT CK_PurchaseOrderHeader_Status CHECK (([Status]>=(1) AND [Status]<=(4))),
    EmployeeID         int         NOT NULL,
    VendorID           int         NOT NULL,
    ShipMethodID       int         NOT NULL,
    OrderDate          datetime    CONSTRAINT [DF_PurchaseOrderHeader_OrderDate] DEFAULT (getdate()) NOT NULL,
    ShipDate           datetime    NULL,
    SubTotal           money       CONSTRAINT [DF_PurchaseOrderHeader_SubTotal] DEFAULT ((0.00)) NOT NULL
                       CONSTRAINT CK_PurchaseOrderHeader_SubTotal CHECK (([SubTotal]>=(0.00))),
    TaxAmt             money       CONSTRAINT [DF_PurchaseOrderHeader_TaxAmt] DEFAULT ((0.00)) NOT NULL
                       CONSTRAINT CK_PurchaseOrderHeader_TaxAmt CHECK (([TaxAmt]>=(0.00))),
    Freight            money       CONSTRAINT [DF_PurchaseOrderHeader_Freight] DEFAULT ((0.00)) NOT NULL
                       CONSTRAINT CK_PurchaseOrderHeader_Freight CHECK (([Freight]>=(0.00))),
    TotalDue           money       NOT NULL,
    ModifiedDate       datetime    CONSTRAINT [DF_PurchaseOrderHeader_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (PurchaseOrderID)
)

go


IF OBJECT_ID('PurchaseOrderHeader') IS NOT NULL
    PRINT '<<< CREATED TABLE PurchaseOrderHeader >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE PurchaseOrderHeader >>>'
go

/* 
 * TABLE: SalesOrderDetail 
 */

CREATE TABLE SalesOrderDetail(
    SalesOrderID             int                 NOT NULL,
    SalesOrderDetailID       int                 IDENTITY(1,1),
    CarrierTrackingNumber    nvarchar(25)        NULL,
    OrderQty                 smallint            NOT NULL
                             CONSTRAINT CK_SalesOrderDetail_OrderQty CHECK (([OrderQty]>(0))),
    ProductID                int                 NOT NULL,
    SpecialOfferID           int                 NOT NULL,
    UnitPrice                money               NOT NULL
                             CONSTRAINT CK_SalesOrderDetail_UnitPrice CHECK (([UnitPrice]>=(0.00))),
    UnitPriceDiscount        money               CONSTRAINT [DF_SalesOrderDetail_UnitPriceDiscount] DEFAULT ((0.0)) NOT NULL
                             CONSTRAINT CK_SalesOrderDetail_UnitPriceDiscount CHECK (([UnitPriceDiscount]>=(0.00))),
    LineTotal                numeric(38, 6)      NOT NULL,
    rowguid                  uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_SalesOrderDetail_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate             datetime            CONSTRAINT [DF_SalesOrderDetail_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (SalesOrderID, SalesOrderDetailID)
)

go


IF OBJECT_ID('SalesOrderDetail') IS NOT NULL
    PRINT '<<< CREATED TABLE SalesOrderDetail >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SalesOrderDetail >>>'
go

/* 
 * TABLE: SalesOrderHeader 
 */

CREATE TABLE SalesOrderHeader(
    SalesOrderID              int                 IDENTITY(1,1) NOT FOR REPLICATION,
    RevisionNumber            tinyint             CONSTRAINT [DF_SalesOrderHeader_RevisionNumber] DEFAULT (0) NOT NULL,
    OrderDate                 datetime            CONSTRAINT [DF_SalesOrderHeader_OrderDate] DEFAULT (getdate()) NOT NULL,
    DueDate                   datetime            NOT NULL,
    ShipDate                  datetime            NULL,
    Status                    tinyint             CONSTRAINT [DF_SalesOrderHeader_Status] DEFAULT (1) NOT NULL
                              CONSTRAINT CK_SalesOrderHeader_Status CHECK (([Status]>=(0) AND [Status]<=(8))),
    OnlineOrderFlag           Flag                CONSTRAINT [DF_SalesOrderHeader_OnlineOrderFlag] DEFAULT ((1)) NOT NULL,
    SalesOrderNumber          nvarchar(25)        NOT NULL,
    PurchaseOrderNumber       OrderNumber         NULL,
    AccountNumber             AccountNumber       NULL,
    CustomerID                int                 NOT NULL,
    ContactID                 int                 NOT NULL,
    SalesPersonID             int                 NULL,
    TerritoryID               int                 NULL,
    BillToAddressID           int                 NOT NULL,
    ShipToAddressID           int                 NOT NULL,
    ShipMethodID              int                 NOT NULL,
    CreditCardID              int                 NULL,
    CreditCardApprovalCode    varchar(15)         NULL,
    CurrencyRateID            int                 NULL,
    SubTotal                  money               CONSTRAINT [DF_SalesOrderHeader_SubTotal] DEFAULT ((0.00)) NOT NULL
                              CONSTRAINT CK_SalesOrderHeader_SubTotal CHECK (([SubTotal]>=(0.00))),
    TaxAmt                    money               CONSTRAINT [DF_SalesOrderHeader_TaxAmt] DEFAULT ((0.00)) NOT NULL
                              CONSTRAINT CK_SalesOrderHeader_TaxAmt CHECK (([TaxAmt]>=(0.00))),
    Freight                   money               CONSTRAINT [DF_SalesOrderHeader_Freight] DEFAULT ((0.00)) NOT NULL
                              CONSTRAINT CK_SalesOrderHeader_Freight CHECK (([Freight]>=(0.00))),
    TotalDue                  money               NOT NULL,
    Comment                   nvarchar(128)       NULL,
    rowguid                   uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_SalesOrderHeader_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate              datetime            CONSTRAINT [DF_SalesOrderHeader_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (SalesOrderID)
)

go


IF OBJECT_ID('SalesOrderHeader') IS NOT NULL
    PRINT '<<< CREATED TABLE SalesOrderHeader >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SalesOrderHeader >>>'
go

/* 
 * TABLE: SalesOrderHeaderSalesReason 
 */

CREATE TABLE SalesOrderHeaderSalesReason(
    SalesOrderID     int         NOT NULL,
    SalesReasonID    int         NOT NULL,
    ModifiedDate     datetime    CONSTRAINT [DF_SalesOrderHeaderSalesReason_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (SalesOrderID, SalesReasonID)
)

go


IF OBJECT_ID('SalesOrderHeaderSalesReason') IS NOT NULL
    PRINT '<<< CREATED TABLE SalesOrderHeaderSalesReason >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SalesOrderHeaderSalesReason >>>'
go

/* 
 * TABLE: SalesPerson 
 */

CREATE TABLE SalesPerson(
    SalesPersonID    int                 NOT NULL,
    TerritoryID      int                 NULL,
    SalesQuota       money               NULL
                     CONSTRAINT CK_SalesPerson_SalesQuota CHECK (([SalesQuota]>(0.00))),
    Bonus            money               CONSTRAINT [DF_SalesPerson_Bonus] DEFAULT ((0.00)) NOT NULL
                     CONSTRAINT CK_SalesPerson_Bonus CHECK (([Bonus]>=(0.00))),
    CommissionPct    smallmoney          CONSTRAINT [DF_SalesPerson_CommissionPct] DEFAULT ((0.00)) NOT NULL
                     CONSTRAINT CK_SalesPerson_CommissionPct CHECK (([CommissionPct]>=(0.00))),
    SalesYTD         money               CONSTRAINT [DF_SalesPerson_SalesYTD] DEFAULT ((0.00)) NOT NULL
                     CONSTRAINT CK_SalesPerson_SalesYTD CHECK (([SalesYTD]>=(0.00))),
    SalesLastYear    money               CONSTRAINT [DF_SalesPerson_SalesLastYear] DEFAULT ((0.00)) NOT NULL
                     CONSTRAINT CK_SalesPerson_SalesLastYear CHECK (([SalesLastYear]>=(0.00))),
    rowguid          uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_SalesPerson_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate     datetime            CONSTRAINT [DF_SalesPerson_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (SalesPersonID)
)

go


IF OBJECT_ID('SalesPerson') IS NOT NULL
    PRINT '<<< CREATED TABLE SalesPerson >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SalesPerson >>>'
go

/* 
 * TABLE: SalesPersonQuotaHistory 
 */

CREATE TABLE SalesPersonQuotaHistory(
    SalesPersonID    int                 NOT NULL,
    QuotaDate        datetime            NOT NULL,
    SalesQuota       money               NOT NULL
                     CONSTRAINT CK_SalesPersonQuotaHistory_SalesQuota CHECK (([SalesQuota]>(0.00))),
    rowguid          uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_SalesPersonQuotaHistory_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate     datetime            CONSTRAINT [DF_SalesPersonQuotaHistory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (SalesPersonID, QuotaDate)
)

go


IF OBJECT_ID('SalesPersonQuotaHistory') IS NOT NULL
    PRINT '<<< CREATED TABLE SalesPersonQuotaHistory >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SalesPersonQuotaHistory >>>'
go

/* 
 * TABLE: SalesReason 
 */

CREATE TABLE SalesReason(
    SalesReasonID    int         IDENTITY(1,1),
    Name             Name        NOT NULL,
    ReasonType       Name        NOT NULL,
    ModifiedDate     datetime    CONSTRAINT [DF_SalesReason_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (SalesReasonID)
)

go


IF OBJECT_ID('SalesReason') IS NOT NULL
    PRINT '<<< CREATED TABLE SalesReason >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SalesReason >>>'
go

/* 
 * TABLE: SalesTaxRate 
 */

CREATE TABLE SalesTaxRate(
    SalesTaxRateID     int                 IDENTITY(1,1),
    StateProvinceID    int                 NOT NULL,
    TaxType            tinyint             NOT NULL
                       CONSTRAINT CK_SalesTaxRate_TaxType CHECK (([TaxType]>=(1) AND [TaxType]<=(3))),
    TaxRate            smallmoney          CONSTRAINT [DF_SalesTaxRate_TaxRate] DEFAULT ((0.00)) NOT NULL,
    Name               Name                NOT NULL,
    rowguid            uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_SalesTaxRate_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate       datetime            CONSTRAINT [DF_SalesTaxRate_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (SalesTaxRateID)
)

go


IF OBJECT_ID('SalesTaxRate') IS NOT NULL
    PRINT '<<< CREATED TABLE SalesTaxRate >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SalesTaxRate >>>'
go

/* 
 * TABLE: SalesTerritory 
 */

CREATE TABLE SalesTerritory(
    TerritoryID          int                 IDENTITY(1,1),
    Name                 Name                NOT NULL,
    CountryRegionCode    nvarchar(3)         NOT NULL,
    Group                nvarchar(50)        NOT NULL,
    SalesYTD             money               CONSTRAINT [DF_SalesTerritory_SalesYTD] DEFAULT ((0.00)) NOT NULL
                         CONSTRAINT CK_SalesTerritory_SalesYTD CHECK (([SalesYTD]>=(0.00))),
    SalesLastYear        money               CONSTRAINT [DF_SalesTerritory_SalesLastYear] DEFAULT ((0.00)) NOT NULL
                         CONSTRAINT CK_SalesTerritory_SalesLastYear CHECK (([SalesLastYear]>=(0.00))),
    CostYTD              money               CONSTRAINT [DF_SalesTerritory_CostYTD] DEFAULT ((0.00)) NOT NULL
                         CONSTRAINT CK_SalesTerritory_CostYTD CHECK (([CostYTD]>=(0.00))),
    CostLastYear         money               CONSTRAINT [DF_SalesTerritory_CostLastYear] DEFAULT ((0.00)) NOT NULL
                         CONSTRAINT CK_SalesTerritory_CostLastYear CHECK (([CostLastYear]>=(0.00))),
    rowguid              uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_SalesTerritory_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate         datetime            CONSTRAINT [DF_SalesTerritory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (TerritoryID)
)

go


IF OBJECT_ID('SalesTerritory') IS NOT NULL
    PRINT '<<< CREATED TABLE SalesTerritory >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SalesTerritory >>>'
go

/* 
 * TABLE: SalesTerritoryHistory 
 */

CREATE TABLE SalesTerritoryHistory(
    SalesPersonID    int                 NOT NULL,
    TerritoryID      int                 NOT NULL,
    StartDate        datetime            NOT NULL,
    EndDate          datetime            NULL,
    rowguid          uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_SalesTerritoryHistory_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate     datetime            CONSTRAINT [DF_SalesTerritoryHistory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (SalesPersonID, StartDate, TerritoryID)
)

go


IF OBJECT_ID('SalesTerritoryHistory') IS NOT NULL
    PRINT '<<< CREATED TABLE SalesTerritoryHistory >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SalesTerritoryHistory >>>'
go

/* 
 * TABLE: ScrapReason 
 */

CREATE TABLE ScrapReason(
    ScrapReasonID    smallint    IDENTITY(1,1),
    Name             Name        NOT NULL,
    ModifiedDate     datetime    CONSTRAINT [DF_ScrapReason_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ScrapReasonID)
)

go


IF OBJECT_ID('ScrapReason') IS NOT NULL
    PRINT '<<< CREATED TABLE ScrapReason >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ScrapReason >>>'
go

/* 
 * TABLE: Shift 
 */

CREATE TABLE Shift(
    ShiftID         tinyint     IDENTITY(1,1),
    Name            Name        NOT NULL,
    StartTime       datetime    NOT NULL,
    EndTime         datetime    NOT NULL,
    ModifiedDate    datetime    CONSTRAINT [DF_Shift_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ShiftID)
)

go


IF OBJECT_ID('Shift') IS NOT NULL
    PRINT '<<< CREATED TABLE Shift >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Shift >>>'
go

/* 
 * TABLE: ShipMethod 
 */

CREATE TABLE ShipMethod(
    ShipMethodID    int                 IDENTITY(1,1),
    Name            Name                NOT NULL,
    ShipBase        money               CONSTRAINT [DF_ShipMethod_ShipBase] DEFAULT ((0.00)) NOT NULL
                    CONSTRAINT CK_ShipMethod_ShipBase CHECK (([ShipBase]>(0.00))),
    ShipRate        money               CONSTRAINT [DF_ShipMethod_ShipRate] DEFAULT ((0.00)) NOT NULL
                    CONSTRAINT CK_ShipMethod_ShipRate CHECK (([ShipRate]>(0.00))),
    rowguid         uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_ShipMethod_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate    datetime            CONSTRAINT [DF_ShipMethod_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ShipMethodID)
)

go


IF OBJECT_ID('ShipMethod') IS NOT NULL
    PRINT '<<< CREATED TABLE ShipMethod >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ShipMethod >>>'
go

/* 
 * TABLE: ShoppingCartItem 
 */

CREATE TABLE ShoppingCartItem(
    ShoppingCartItemID    int             IDENTITY(1,1),
    ShoppingCartID        nvarchar(50)    NOT NULL,
    Quantity              int             CONSTRAINT [DF_ShoppingCartItem_Quantity] DEFAULT (1) NOT NULL
                          CONSTRAINT CK_ShoppingCartItem_Quantity CHECK (([Quantity]>=(1))),
    ProductID             int             NOT NULL,
    DateCreated           datetime        CONSTRAINT [DF_ShoppingCartItem_DateCreated] DEFAULT (getdate()) NOT NULL,
    ModifiedDate          datetime        CONSTRAINT [DF_ShoppingCartItem_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (ShoppingCartItemID)
)

go


IF OBJECT_ID('ShoppingCartItem') IS NOT NULL
    PRINT '<<< CREATED TABLE ShoppingCartItem >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE ShoppingCartItem >>>'
go

/* 
 * TABLE: SpecialOffer 
 */

CREATE TABLE SpecialOffer(
    SpecialOfferID    int                 IDENTITY(1,1),
    Description       nvarchar(255)       NOT NULL,
    DiscountPct       smallmoney          CONSTRAINT [DF_SpecialOffer_DiscountPct] DEFAULT ((0.00)) NOT NULL
                      CONSTRAINT CK_SpecialOffer_DiscountPct CHECK (([DiscountPct]>=(0.00))),
    Type              nvarchar(50)        NOT NULL,
    Category          nvarchar(50)        NOT NULL,
    StartDate         datetime            NOT NULL,
    EndDate           datetime            NOT NULL,
    MinQty            int                 CONSTRAINT [DF_SpecialOffer_MinQty] DEFAULT (0) NOT NULL
                      CONSTRAINT CK_SpecialOffer_MinQty CHECK (([MinQty]>=(0))),
    MaxQty            int                 NULL
                      CONSTRAINT CK_SpecialOffer_MaxQty CHECK (([MaxQty]>=(0))),
    rowguid           uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_SpecialOffer_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate      datetime            CONSTRAINT [DF_SpecialOffer_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (SpecialOfferID)
)

go


IF OBJECT_ID('SpecialOffer') IS NOT NULL
    PRINT '<<< CREATED TABLE SpecialOffer >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SpecialOffer >>>'
go

/* 
 * TABLE: SpecialOfferProduct 
 */

CREATE TABLE SpecialOfferProduct(
    SpecialOfferID    int                 NOT NULL,
    ProductID         int                 NOT NULL,
    rowguid           uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_SpecialOfferProduct_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate      datetime            CONSTRAINT [DF_SpecialOfferProduct_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (SpecialOfferID, ProductID)
)

go


IF OBJECT_ID('SpecialOfferProduct') IS NOT NULL
    PRINT '<<< CREATED TABLE SpecialOfferProduct >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE SpecialOfferProduct >>>'
go

/* 
 * TABLE: StateProvince 
 */

CREATE TABLE StateProvince(
    StateProvinceID            int                 IDENTITY(1,1),
    StateProvinceCode          nchar(3)            NOT NULL,
    CountryRegionCode          nvarchar(3)         NOT NULL,
    IsOnlyStateProvinceFlag    Flag                CONSTRAINT [DF_StateProvince_IsOnlyStateProvinceFlag] DEFAULT ((1)) NOT NULL,
    Name                       Name                NOT NULL,
    TerritoryID                int                 NOT NULL,
    rowguid                    uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_StateProvince_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate               datetime            CONSTRAINT [DF_StateProvince_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (StateProvinceID)
)

go


IF OBJECT_ID('StateProvince') IS NOT NULL
    PRINT '<<< CREATED TABLE StateProvince >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE StateProvince >>>'
go

/* 
 * TABLE: Store 
 */

CREATE TABLE Store(
    CustomerID       int                 NOT NULL,
    Name             Name                NOT NULL,
    SalesPersonID    int                 NULL,
    Demographics     xml                 (CONTENT Sales.StoreSurveySchemaCollection) NULL,
    rowguid          uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_Store_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate     datetime            CONSTRAINT [DF_Store_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (CustomerID)
)

go


IF OBJECT_ID('Store') IS NOT NULL
    PRINT '<<< CREATED TABLE Store >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Store >>>'
go

/* 
 * TABLE: StoreContact 
 */

CREATE TABLE StoreContact(
    CustomerID       int                 NOT NULL,
    ContactID        int                 NOT NULL,
    ContactTypeID    int                 NOT NULL,
    rowguid          uniqueidentifier    ROWGUIDCOL CONSTRAINT [DF_StoreContact_rowguid] DEFAULT (newid()) NOT NULL,
    ModifiedDate     datetime            CONSTRAINT [DF_StoreContact_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (CustomerID, ContactID)
)

go


IF OBJECT_ID('StoreContact') IS NOT NULL
    PRINT '<<< CREATED TABLE StoreContact >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE StoreContact >>>'
go

/* 
 * TABLE: TransactionHistory 
 */

CREATE TABLE TransactionHistory(
    TransactionID           int         IDENTITY(100000,1),
    ProductID               int         NOT NULL,
    ReferenceOrderID        int         NOT NULL,
    ReferenceOrderLineID    int         CONSTRAINT [DF_TransactionHistory_ReferenceOrderLineID] DEFAULT (0) NOT NULL,
    TransactionDate         datetime    CONSTRAINT [DF_TransactionHistory_TransactionDate] DEFAULT (getdate()) NOT NULL,
    TransactionType         nchar(1)    NOT NULL
                            CONSTRAINT CK_TransactionHistory_TransactionType CHECK ((upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W')),
    Quantity                int         NOT NULL,
    ActualCost              money       NOT NULL,
    ModifiedDate            datetime    CONSTRAINT [DF_TransactionHistory_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (TransactionID)
)

go


IF OBJECT_ID('TransactionHistory') IS NOT NULL
    PRINT '<<< CREATED TABLE TransactionHistory >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TransactionHistory >>>'
go

/* 
 * TABLE: TransactionHistoryArchive 
 */

CREATE TABLE TransactionHistoryArchive(
    TransactionID           int         NOT NULL,
    ProductID               int         NOT NULL,
    ReferenceOrderID        int         NOT NULL,
    ReferenceOrderLineID    int         CONSTRAINT [DF_TransactionHistoryArchive_ReferenceOrderLineID] DEFAULT (0) NOT NULL,
    TransactionDate         datetime    CONSTRAINT [DF_TransactionHistoryArchive_TransactionDate] DEFAULT (getdate()) NOT NULL,
    TransactionType         nchar(1)    NOT NULL
                            CONSTRAINT CK_TransactionHistoryArchive_TransactionType CHECK ((upper([TransactionType])='P' OR upper([TransactionType])='S' OR upper([TransactionType])='W')),
    Quantity                int         NOT NULL,
    ActualCost              money       NOT NULL,
    ModifiedDate            datetime    CONSTRAINT [DF_TransactionHistoryArchive_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (TransactionID)
)

go


IF OBJECT_ID('TransactionHistoryArchive') IS NOT NULL
    PRINT '<<< CREATED TABLE TransactionHistoryArchive >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE TransactionHistoryArchive >>>'
go

/* 
 * TABLE: UnitMeasure 
 */

CREATE TABLE UnitMeasure(
    UnitMeasureCode    nchar(3)    NOT NULL,
    Name               Name        NOT NULL,
    ModifiedDate       datetime    CONSTRAINT [DF_UnitMeasure_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (UnitMeasureCode)
)

go


IF OBJECT_ID('UnitMeasure') IS NOT NULL
    PRINT '<<< CREATED TABLE UnitMeasure >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE UnitMeasure >>>'
go

/* 
 * TABLE: Vendor 
 */

CREATE TABLE Vendor(
    VendorID                   int               IDENTITY(1,1),
    AccountNumber              AccountNumber     NOT NULL,
    Name                       Name              NOT NULL,
    CreditRating               tinyint           NOT NULL
                               CONSTRAINT CK_Vendor_CreditRating CHECK (([CreditRating]>=(1) AND [CreditRating]<=(5))),
    PreferredVendorStatus      Flag              CONSTRAINT [DF_Vendor_PreferredVendorStatus] DEFAULT ((1)) NOT NULL,
    ActiveFlag                 Flag              CONSTRAINT [DF_Vendor_ActiveFlag] DEFAULT ((1)) NOT NULL,
    PurchasingWebServiceURL    nvarchar(1024)    NULL,
    ModifiedDate               datetime          CONSTRAINT [DF_Vendor_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (VendorID)
)

go


IF OBJECT_ID('Vendor') IS NOT NULL
    PRINT '<<< CREATED TABLE Vendor >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Vendor >>>'
go

/* 
 * TABLE: VendorAddress 
 */

CREATE TABLE VendorAddress(
    VendorID         int         NOT NULL,
    AddressID        int         NOT NULL,
    AddressTypeID    int         NOT NULL,
    ModifiedDate     datetime    CONSTRAINT [DF_VendorAddress_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (VendorID, AddressID)
)

go


IF OBJECT_ID('VendorAddress') IS NOT NULL
    PRINT '<<< CREATED TABLE VendorAddress >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE VendorAddress >>>'
go

/* 
 * TABLE: VendorContact 
 */

CREATE TABLE VendorContact(
    VendorID         int         NOT NULL,
    ContactID        int         NOT NULL,
    ContactTypeID    int         NOT NULL,
    ModifiedDate     datetime    CONSTRAINT [DF_VendorContact_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (VendorID, ContactID)
)

go


IF OBJECT_ID('VendorContact') IS NOT NULL
    PRINT '<<< CREATED TABLE VendorContact >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE VendorContact >>>'
go

/* 
 * TABLE: WorkOrder 
 */

CREATE TABLE WorkOrder(
    WorkOrderID      int         IDENTITY(1,1),
    ProductID        int         NOT NULL,
    OrderQty         int         NOT NULL
                     CONSTRAINT CK_WorkOrder_OrderQty CHECK (([OrderQty]>(0))),
    StockedQty       int         NOT NULL,
    ScrappedQty      smallint    NOT NULL
                     CONSTRAINT CK_WorkOrder_ScrappedQty CHECK (([ScrappedQty]>=(0))),
    StartDate        datetime    NOT NULL,
    EndDate          datetime    NULL,
    DueDate          datetime    NOT NULL,
    ScrapReasonID    smallint    NULL,
    ModifiedDate     datetime    CONSTRAINT [DF_WorkOrder_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (WorkOrderID)
)

go


IF OBJECT_ID('WorkOrder') IS NOT NULL
    PRINT '<<< CREATED TABLE WorkOrder >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE WorkOrder >>>'
go

/* 
 * TABLE: WorkOrderRouting 
 */

CREATE TABLE WorkOrderRouting(
    WorkOrderID           int              NOT NULL,
    ProductID             int              NOT NULL,
    OperationSequence     smallint         NOT NULL,
    LocationID            smallint         NOT NULL,
    ScheduledStartDate    datetime         NOT NULL,
    ScheduledEndDate      datetime         NOT NULL,
    ActualStartDate       datetime         NULL,
    ActualEndDate         datetime         NULL,
    ActualResourceHrs     decimal(9, 4)    NULL
                          CONSTRAINT CK_WorkOrderRouting_ActualResourceHrs CHECK (([ActualResourceHrs]>=(0.0000))),
    PlannedCost           money            NOT NULL
                          CONSTRAINT CK_WorkOrderRouting_PlannedCost CHECK (([PlannedCost]>(0.00))),
    ActualCost            money            NULL
                          CONSTRAINT CK_WorkOrderRouting_ActualCost CHECK (([ActualCost]>(0.00))),
    ModifiedDate          datetime         CONSTRAINT [DF_WorkOrderRouting_ModifiedDate] DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED (WorkOrderID, ProductID, OperationSequence)
)

go


IF OBJECT_ID('WorkOrderRouting') IS NOT NULL
    PRINT '<<< CREATED TABLE WorkOrderRouting >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE WorkOrderRouting >>>'
go

/* 
 * INDEX: IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode 
 */

CREATE UNIQUE INDEX IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode ON Address(AddressLine1, AddressLine2, City, StateProvinceID, PostalCode)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Address') AND name='IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode')
    PRINT '<<< CREATED INDEX Address.IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Address.IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode >>>'
go

/* 
 * INDEX: AK_Address_rowguid 
 */

CREATE UNIQUE INDEX AK_Address_rowguid ON Address(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Address') AND name='AK_Address_rowguid')
    PRINT '<<< CREATED INDEX Address.AK_Address_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Address.AK_Address_rowguid >>>'
go

/* 
 * INDEX: IX_Address_StateProvinceID 
 */

CREATE INDEX IX_Address_StateProvinceID ON Address(StateProvinceID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Address') AND name='IX_Address_StateProvinceID')
    PRINT '<<< CREATED INDEX Address.IX_Address_StateProvinceID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Address.IX_Address_StateProvinceID >>>'
go

/* 
 * INDEX: AK_AddressType_rowguid 
 */

CREATE UNIQUE INDEX AK_AddressType_rowguid ON AddressType(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('AddressType') AND name='AK_AddressType_rowguid')
    PRINT '<<< CREATED INDEX AddressType.AK_AddressType_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX AddressType.AK_AddressType_rowguid >>>'
go

/* 
 * INDEX: AK_AddressType_Name 
 */

CREATE UNIQUE INDEX AK_AddressType_Name ON AddressType(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('AddressType') AND name='AK_AddressType_Name')
    PRINT '<<< CREATED INDEX AddressType.AK_AddressType_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX AddressType.AK_AddressType_Name >>>'
go

/* 
 * INDEX: AK_BillOfMaterials_ProductAssemblyID_ComponentID_StartDate 
 */

CREATE UNIQUE CLUSTERED INDEX AK_BillOfMaterials_ProductAssemblyID_ComponentID_StartDate ON BillOfMaterials(ProductAssemblyID, ComponentID, StartDate)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('BillOfMaterials') AND name='AK_BillOfMaterials_ProductAssemblyID_ComponentID_StartDate')
    PRINT '<<< CREATED INDEX BillOfMaterials.AK_BillOfMaterials_ProductAssemblyID_ComponentID_StartDate >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX BillOfMaterials.AK_BillOfMaterials_ProductAssemblyID_ComponentID_StartDate >>>'
go

/* 
 * INDEX: IX_BillOfMaterials_UnitMeasureCode 
 */

CREATE INDEX IX_BillOfMaterials_UnitMeasureCode ON BillOfMaterials(UnitMeasureCode)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('BillOfMaterials') AND name='IX_BillOfMaterials_UnitMeasureCode')
    PRINT '<<< CREATED INDEX BillOfMaterials.IX_BillOfMaterials_UnitMeasureCode >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX BillOfMaterials.IX_BillOfMaterials_UnitMeasureCode >>>'
go

/* 
 * INDEX: IX_Contact_EmailAddress 
 */

CREATE INDEX IX_Contact_EmailAddress ON Contact(EmailAddress)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Contact') AND name='IX_Contact_EmailAddress')
    PRINT '<<< CREATED INDEX Contact.IX_Contact_EmailAddress >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Contact.IX_Contact_EmailAddress >>>'
go

/* 
 * INDEX: AK_Contact_rowguid 
 */

CREATE UNIQUE INDEX AK_Contact_rowguid ON Contact(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Contact') AND name='AK_Contact_rowguid')
    PRINT '<<< CREATED INDEX Contact.AK_Contact_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Contact.AK_Contact_rowguid >>>'
go

/* 
 * INDEX: AK_ContactType_Name 
 */

CREATE UNIQUE INDEX AK_ContactType_Name ON ContactType(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('ContactType') AND name='AK_ContactType_Name')
    PRINT '<<< CREATED INDEX ContactType.AK_ContactType_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX ContactType.AK_ContactType_Name >>>'
go

/* 
 * INDEX: AK_CountryRegion_Name 
 */

CREATE UNIQUE INDEX AK_CountryRegion_Name ON CountryRegion(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('CountryRegion') AND name='AK_CountryRegion_Name')
    PRINT '<<< CREATED INDEX CountryRegion.AK_CountryRegion_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX CountryRegion.AK_CountryRegion_Name >>>'
go

/* 
 * INDEX: IX_CountryRegionCurrency_CurrencyCode 
 */

CREATE INDEX IX_CountryRegionCurrency_CurrencyCode ON CountryRegionCurrency(CurrencyCode)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('CountryRegionCurrency') AND name='IX_CountryRegionCurrency_CurrencyCode')
    PRINT '<<< CREATED INDEX CountryRegionCurrency.IX_CountryRegionCurrency_CurrencyCode >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX CountryRegionCurrency.IX_CountryRegionCurrency_CurrencyCode >>>'
go

/* 
 * INDEX: AK_CreditCard_CardNumber 
 */

CREATE UNIQUE INDEX AK_CreditCard_CardNumber ON CreditCard(CardNumber)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('CreditCard') AND name='AK_CreditCard_CardNumber')
    PRINT '<<< CREATED INDEX CreditCard.AK_CreditCard_CardNumber >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX CreditCard.AK_CreditCard_CardNumber >>>'
go

/* 
 * INDEX: AK_Culture_Name 
 */

CREATE UNIQUE INDEX AK_Culture_Name ON Culture(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Culture') AND name='AK_Culture_Name')
    PRINT '<<< CREATED INDEX Culture.AK_Culture_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Culture.AK_Culture_Name >>>'
go

/* 
 * INDEX: AK_Currency_Name 
 */

CREATE UNIQUE INDEX AK_Currency_Name ON Currency(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Currency') AND name='AK_Currency_Name')
    PRINT '<<< CREATED INDEX Currency.AK_Currency_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Currency.AK_Currency_Name >>>'
go

/* 
 * INDEX: AK_CurrencyRate_CurrencyRateDate_FromCurrencyCode_ToCurrencyCode 
 */

CREATE UNIQUE INDEX AK_CurrencyRate_CurrencyRateDate_FromCurrencyCode_ToCurrencyCode ON CurrencyRate(CurrencyRateDate, FromCurrencyCode, ToCurrencyCode)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('CurrencyRate') AND name='AK_CurrencyRate_CurrencyRateDate_FromCurrencyCode_ToCurrencyCode')
    PRINT '<<< CREATED INDEX CurrencyRate.AK_CurrencyRate_CurrencyRateDate_FromCurrencyCode_ToCurrencyCode >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX CurrencyRate.AK_CurrencyRate_CurrencyRateDate_FromCurrencyCode_ToCurrencyCode >>>'
go

/* 
 * INDEX: AK_Customer_rowguid 
 */

CREATE UNIQUE INDEX AK_Customer_rowguid ON Customer(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Customer') AND name='AK_Customer_rowguid')
    PRINT '<<< CREATED INDEX Customer.AK_Customer_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Customer.AK_Customer_rowguid >>>'
go

/* 
 * INDEX: AK_Customer_AccountNumber 
 */

CREATE UNIQUE INDEX AK_Customer_AccountNumber ON Customer(AccountNumber)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Customer') AND name='AK_Customer_AccountNumber')
    PRINT '<<< CREATED INDEX Customer.AK_Customer_AccountNumber >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Customer.AK_Customer_AccountNumber >>>'
go

/* 
 * INDEX: IX_Customer_TerritoryID 
 */

CREATE INDEX IX_Customer_TerritoryID ON Customer(TerritoryID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Customer') AND name='IX_Customer_TerritoryID')
    PRINT '<<< CREATED INDEX Customer.IX_Customer_TerritoryID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Customer.IX_Customer_TerritoryID >>>'
go

/* 
 * INDEX: AK_CustomerAddress_rowguid 
 */

CREATE UNIQUE INDEX AK_CustomerAddress_rowguid ON CustomerAddress(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('CustomerAddress') AND name='AK_CustomerAddress_rowguid')
    PRINT '<<< CREATED INDEX CustomerAddress.AK_CustomerAddress_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX CustomerAddress.AK_CustomerAddress_rowguid >>>'
go

/* 
 * INDEX: AK_Department_Name 
 */

CREATE UNIQUE INDEX AK_Department_Name ON Department(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Department') AND name='AK_Department_Name')
    PRINT '<<< CREATED INDEX Department.AK_Department_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Department.AK_Department_Name >>>'
go

/* 
 * INDEX: AK_Document_FileName_Revision 
 */

CREATE UNIQUE INDEX AK_Document_FileName_Revision ON Document(FileName, Revision)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Document') AND name='AK_Document_FileName_Revision')
    PRINT '<<< CREATED INDEX Document.AK_Document_FileName_Revision >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Document.AK_Document_FileName_Revision >>>'
go

/* 
 * INDEX: IX_Employee_ManagerID 
 */

CREATE INDEX IX_Employee_ManagerID ON Employee(ManagerID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Employee') AND name='IX_Employee_ManagerID')
    PRINT '<<< CREATED INDEX Employee.IX_Employee_ManagerID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Employee.IX_Employee_ManagerID >>>'
go

/* 
 * INDEX: AK_Employee_NationalIDNumber 
 */

CREATE UNIQUE INDEX AK_Employee_NationalIDNumber ON Employee(NationalIDNumber)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Employee') AND name='AK_Employee_NationalIDNumber')
    PRINT '<<< CREATED INDEX Employee.AK_Employee_NationalIDNumber >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Employee.AK_Employee_NationalIDNumber >>>'
go

/* 
 * INDEX: AK_Employee_rowguid 
 */

CREATE UNIQUE INDEX AK_Employee_rowguid ON Employee(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Employee') AND name='AK_Employee_rowguid')
    PRINT '<<< CREATED INDEX Employee.AK_Employee_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Employee.AK_Employee_rowguid >>>'
go

/* 
 * INDEX: AK_Employee_LoginID 
 */

CREATE UNIQUE INDEX AK_Employee_LoginID ON Employee(LoginID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Employee') AND name='AK_Employee_LoginID')
    PRINT '<<< CREATED INDEX Employee.AK_Employee_LoginID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Employee.AK_Employee_LoginID >>>'
go

/* 
 * INDEX: AK_EmployeeAddress_rowguid 
 */

CREATE UNIQUE INDEX AK_EmployeeAddress_rowguid ON EmployeeAddress(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('EmployeeAddress') AND name='AK_EmployeeAddress_rowguid')
    PRINT '<<< CREATED INDEX EmployeeAddress.AK_EmployeeAddress_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX EmployeeAddress.AK_EmployeeAddress_rowguid >>>'
go

/* 
 * INDEX: IX_EmployeeDepartmentHistory_DepartmentID 
 */

CREATE INDEX IX_EmployeeDepartmentHistory_DepartmentID ON EmployeeDepartmentHistory(DepartmentID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('EmployeeDepartmentHistory') AND name='IX_EmployeeDepartmentHistory_DepartmentID')
    PRINT '<<< CREATED INDEX EmployeeDepartmentHistory.IX_EmployeeDepartmentHistory_DepartmentID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX EmployeeDepartmentHistory.IX_EmployeeDepartmentHistory_DepartmentID >>>'
go

/* 
 * INDEX: IX_EmployeeDepartmentHistory_ShiftID 
 */

CREATE INDEX IX_EmployeeDepartmentHistory_ShiftID ON EmployeeDepartmentHistory(ShiftID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('EmployeeDepartmentHistory') AND name='IX_EmployeeDepartmentHistory_ShiftID')
    PRINT '<<< CREATED INDEX EmployeeDepartmentHistory.IX_EmployeeDepartmentHistory_ShiftID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX EmployeeDepartmentHistory.IX_EmployeeDepartmentHistory_ShiftID >>>'
go

/* 
 * INDEX: IX_JobCandidate_EmployeeID 
 */

CREATE INDEX IX_JobCandidate_EmployeeID ON JobCandidate(EmployeeID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('JobCandidate') AND name='IX_JobCandidate_EmployeeID')
    PRINT '<<< CREATED INDEX JobCandidate.IX_JobCandidate_EmployeeID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX JobCandidate.IX_JobCandidate_EmployeeID >>>'
go

/* 
 * INDEX: AK_Location_Name 
 */

CREATE UNIQUE INDEX AK_Location_Name ON Location(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Location') AND name='AK_Location_Name')
    PRINT '<<< CREATED INDEX Location.AK_Location_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Location.AK_Location_Name >>>'
go

/* 
 * INDEX: AK_Product_ProductNumber 
 */

CREATE UNIQUE INDEX AK_Product_ProductNumber ON Product(ProductNumber)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Product') AND name='AK_Product_ProductNumber')
    PRINT '<<< CREATED INDEX Product.AK_Product_ProductNumber >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Product.AK_Product_ProductNumber >>>'
go

/* 
 * INDEX: AK_Product_rowguid 
 */

CREATE UNIQUE INDEX AK_Product_rowguid ON Product(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Product') AND name='AK_Product_rowguid')
    PRINT '<<< CREATED INDEX Product.AK_Product_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Product.AK_Product_rowguid >>>'
go

/* 
 * INDEX: AK_Product_Name 
 */

CREATE UNIQUE INDEX AK_Product_Name ON Product(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Product') AND name='AK_Product_Name')
    PRINT '<<< CREATED INDEX Product.AK_Product_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Product.AK_Product_Name >>>'
go

/* 
 * INDEX: AK_ProductCategory_Name 
 */

CREATE UNIQUE INDEX AK_ProductCategory_Name ON ProductCategory(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('ProductCategory') AND name='AK_ProductCategory_Name')
    PRINT '<<< CREATED INDEX ProductCategory.AK_ProductCategory_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX ProductCategory.AK_ProductCategory_Name >>>'
go

/* 
 * INDEX: AK_ProductCategory_rowguid 
 */

CREATE UNIQUE INDEX AK_ProductCategory_rowguid ON ProductCategory(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('ProductCategory') AND name='AK_ProductCategory_rowguid')
    PRINT '<<< CREATED INDEX ProductCategory.AK_ProductCategory_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX ProductCategory.AK_ProductCategory_rowguid >>>'
go

/* 
 * INDEX: AK_ProductDescription_rowguid 
 */

CREATE UNIQUE INDEX AK_ProductDescription_rowguid ON ProductDescription(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('ProductDescription') AND name='AK_ProductDescription_rowguid')
    PRINT '<<< CREATED INDEX ProductDescription.AK_ProductDescription_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX ProductDescription.AK_ProductDescription_rowguid >>>'
go

/* 
 * INDEX: AK_ProductModel_Name 
 */

CREATE UNIQUE INDEX AK_ProductModel_Name ON ProductModel(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('ProductModel') AND name='AK_ProductModel_Name')
    PRINT '<<< CREATED INDEX ProductModel.AK_ProductModel_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX ProductModel.AK_ProductModel_Name >>>'
go

/* 
 * INDEX: AK_ProductModel_rowguid 
 */

CREATE UNIQUE INDEX AK_ProductModel_rowguid ON ProductModel(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('ProductModel') AND name='AK_ProductModel_rowguid')
    PRINT '<<< CREATED INDEX ProductModel.AK_ProductModel_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX ProductModel.AK_ProductModel_rowguid >>>'
go

/* 
 * INDEX: IX_ProductReview_ProductID_Name 
 */

CREATE INDEX IX_ProductReview_ProductID_Name ON ProductReview(ProductID, ReviewerName)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('ProductReview') AND name='IX_ProductReview_ProductID_Name')
    PRINT '<<< CREATED INDEX ProductReview.IX_ProductReview_ProductID_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX ProductReview.IX_ProductReview_ProductID_Name >>>'
go

/* 
 * INDEX: AK_ProductSubcategory_Name 
 */

CREATE UNIQUE INDEX AK_ProductSubcategory_Name ON ProductSubcategory(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('ProductSubcategory') AND name='AK_ProductSubcategory_Name')
    PRINT '<<< CREATED INDEX ProductSubcategory.AK_ProductSubcategory_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX ProductSubcategory.AK_ProductSubcategory_Name >>>'
go

/* 
 * INDEX: AK_ProductSubcategory_rowguid 
 */

CREATE UNIQUE INDEX AK_ProductSubcategory_rowguid ON ProductSubcategory(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('ProductSubcategory') AND name='AK_ProductSubcategory_rowguid')
    PRINT '<<< CREATED INDEX ProductSubcategory.AK_ProductSubcategory_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX ProductSubcategory.AK_ProductSubcategory_rowguid >>>'
go

/* 
 * INDEX: IX_ProductVendor_VendorID 
 */

CREATE INDEX IX_ProductVendor_VendorID ON ProductVendor(VendorID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('ProductVendor') AND name='IX_ProductVendor_VendorID')
    PRINT '<<< CREATED INDEX ProductVendor.IX_ProductVendor_VendorID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX ProductVendor.IX_ProductVendor_VendorID >>>'
go

/* 
 * INDEX: IX_ProductVendor_UnitMeasureCode 
 */

CREATE INDEX IX_ProductVendor_UnitMeasureCode ON ProductVendor(UnitMeasureCode)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('ProductVendor') AND name='IX_ProductVendor_UnitMeasureCode')
    PRINT '<<< CREATED INDEX ProductVendor.IX_ProductVendor_UnitMeasureCode >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX ProductVendor.IX_ProductVendor_UnitMeasureCode >>>'
go

/* 
 * INDEX: IX_PurchaseOrderDetail_ProductID 
 */

CREATE INDEX IX_PurchaseOrderDetail_ProductID ON PurchaseOrderDetail(ProductID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('PurchaseOrderDetail') AND name='IX_PurchaseOrderDetail_ProductID')
    PRINT '<<< CREATED INDEX PurchaseOrderDetail.IX_PurchaseOrderDetail_ProductID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX PurchaseOrderDetail.IX_PurchaseOrderDetail_ProductID >>>'
go

/* 
 * INDEX: IX_PurchaseOrderHeader_VendorID 
 */

CREATE INDEX IX_PurchaseOrderHeader_VendorID ON PurchaseOrderHeader(VendorID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('PurchaseOrderHeader') AND name='IX_PurchaseOrderHeader_VendorID')
    PRINT '<<< CREATED INDEX PurchaseOrderHeader.IX_PurchaseOrderHeader_VendorID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX PurchaseOrderHeader.IX_PurchaseOrderHeader_VendorID >>>'
go

/* 
 * INDEX: IX_PurchaseOrderHeader_EmployeeID 
 */

CREATE INDEX IX_PurchaseOrderHeader_EmployeeID ON PurchaseOrderHeader(EmployeeID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('PurchaseOrderHeader') AND name='IX_PurchaseOrderHeader_EmployeeID')
    PRINT '<<< CREATED INDEX PurchaseOrderHeader.IX_PurchaseOrderHeader_EmployeeID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX PurchaseOrderHeader.IX_PurchaseOrderHeader_EmployeeID >>>'
go

/* 
 * INDEX: AK_SalesOrderDetail_rowguid 
 */

CREATE UNIQUE INDEX AK_SalesOrderDetail_rowguid ON SalesOrderDetail(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SalesOrderDetail') AND name='AK_SalesOrderDetail_rowguid')
    PRINT '<<< CREATED INDEX SalesOrderDetail.AK_SalesOrderDetail_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SalesOrderDetail.AK_SalesOrderDetail_rowguid >>>'
go

/* 
 * INDEX: IX_SalesOrderDetail_ProductID 
 */

CREATE INDEX IX_SalesOrderDetail_ProductID ON SalesOrderDetail(ProductID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SalesOrderDetail') AND name='IX_SalesOrderDetail_ProductID')
    PRINT '<<< CREATED INDEX SalesOrderDetail.IX_SalesOrderDetail_ProductID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SalesOrderDetail.IX_SalesOrderDetail_ProductID >>>'
go

/* 
 * INDEX: AK_SalesOrderHeader_rowguid 
 */

CREATE UNIQUE INDEX AK_SalesOrderHeader_rowguid ON SalesOrderHeader(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SalesOrderHeader') AND name='AK_SalesOrderHeader_rowguid')
    PRINT '<<< CREATED INDEX SalesOrderHeader.AK_SalesOrderHeader_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SalesOrderHeader.AK_SalesOrderHeader_rowguid >>>'
go

/* 
 * INDEX: IX_SalesOrderHeader_SalesPersonID 
 */

CREATE INDEX IX_SalesOrderHeader_SalesPersonID ON SalesOrderHeader(SalesPersonID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SalesOrderHeader') AND name='IX_SalesOrderHeader_SalesPersonID')
    PRINT '<<< CREATED INDEX SalesOrderHeader.IX_SalesOrderHeader_SalesPersonID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SalesOrderHeader.IX_SalesOrderHeader_SalesPersonID >>>'
go

/* 
 * INDEX: AK_SalesOrderHeader_SalesOrderNumber 
 */

CREATE UNIQUE INDEX AK_SalesOrderHeader_SalesOrderNumber ON SalesOrderHeader(SalesOrderNumber)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SalesOrderHeader') AND name='AK_SalesOrderHeader_SalesOrderNumber')
    PRINT '<<< CREATED INDEX SalesOrderHeader.AK_SalesOrderHeader_SalesOrderNumber >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SalesOrderHeader.AK_SalesOrderHeader_SalesOrderNumber >>>'
go

/* 
 * INDEX: IX_SalesOrderHeader_CustomerID 
 */

CREATE INDEX IX_SalesOrderHeader_CustomerID ON SalesOrderHeader(CustomerID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SalesOrderHeader') AND name='IX_SalesOrderHeader_CustomerID')
    PRINT '<<< CREATED INDEX SalesOrderHeader.IX_SalesOrderHeader_CustomerID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SalesOrderHeader.IX_SalesOrderHeader_CustomerID >>>'
go

/* 
 * INDEX: AK_SalesPerson_rowguid 
 */

CREATE UNIQUE INDEX AK_SalesPerson_rowguid ON SalesPerson(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SalesPerson') AND name='AK_SalesPerson_rowguid')
    PRINT '<<< CREATED INDEX SalesPerson.AK_SalesPerson_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SalesPerson.AK_SalesPerson_rowguid >>>'
go

/* 
 * INDEX: AK_SalesPersonQuotaHistory_rowguid 
 */

CREATE UNIQUE INDEX AK_SalesPersonQuotaHistory_rowguid ON SalesPersonQuotaHistory(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SalesPersonQuotaHistory') AND name='AK_SalesPersonQuotaHistory_rowguid')
    PRINT '<<< CREATED INDEX SalesPersonQuotaHistory.AK_SalesPersonQuotaHistory_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SalesPersonQuotaHistory.AK_SalesPersonQuotaHistory_rowguid >>>'
go

/* 
 * INDEX: AK_SalesTaxRate_rowguid 
 */

CREATE UNIQUE INDEX AK_SalesTaxRate_rowguid ON SalesTaxRate(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SalesTaxRate') AND name='AK_SalesTaxRate_rowguid')
    PRINT '<<< CREATED INDEX SalesTaxRate.AK_SalesTaxRate_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SalesTaxRate.AK_SalesTaxRate_rowguid >>>'
go

/* 
 * INDEX: AK_SalesTaxRate_StateProvinceID_TaxType 
 */

CREATE UNIQUE INDEX AK_SalesTaxRate_StateProvinceID_TaxType ON SalesTaxRate(StateProvinceID, TaxType)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SalesTaxRate') AND name='AK_SalesTaxRate_StateProvinceID_TaxType')
    PRINT '<<< CREATED INDEX SalesTaxRate.AK_SalesTaxRate_StateProvinceID_TaxType >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SalesTaxRate.AK_SalesTaxRate_StateProvinceID_TaxType >>>'
go

/* 
 * INDEX: AK_SalesTerritory_Name 
 */

CREATE UNIQUE INDEX AK_SalesTerritory_Name ON SalesTerritory(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SalesTerritory') AND name='AK_SalesTerritory_Name')
    PRINT '<<< CREATED INDEX SalesTerritory.AK_SalesTerritory_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SalesTerritory.AK_SalesTerritory_Name >>>'
go

/* 
 * INDEX: AK_SalesTerritory_rowguid 
 */

CREATE UNIQUE INDEX AK_SalesTerritory_rowguid ON SalesTerritory(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SalesTerritory') AND name='AK_SalesTerritory_rowguid')
    PRINT '<<< CREATED INDEX SalesTerritory.AK_SalesTerritory_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SalesTerritory.AK_SalesTerritory_rowguid >>>'
go

/* 
 * INDEX: AK_SalesTerritoryHistory_rowguid 
 */

CREATE UNIQUE INDEX AK_SalesTerritoryHistory_rowguid ON SalesTerritoryHistory(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SalesTerritoryHistory') AND name='AK_SalesTerritoryHistory_rowguid')
    PRINT '<<< CREATED INDEX SalesTerritoryHistory.AK_SalesTerritoryHistory_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SalesTerritoryHistory.AK_SalesTerritoryHistory_rowguid >>>'
go

/* 
 * INDEX: AK_ScrapReason_Name 
 */

CREATE UNIQUE INDEX AK_ScrapReason_Name ON ScrapReason(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('ScrapReason') AND name='AK_ScrapReason_Name')
    PRINT '<<< CREATED INDEX ScrapReason.AK_ScrapReason_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX ScrapReason.AK_ScrapReason_Name >>>'
go

/* 
 * INDEX: AK_Shift_StartTime_EndTime 
 */

CREATE UNIQUE INDEX AK_Shift_StartTime_EndTime ON Shift(StartTime, EndTime)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Shift') AND name='AK_Shift_StartTime_EndTime')
    PRINT '<<< CREATED INDEX Shift.AK_Shift_StartTime_EndTime >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Shift.AK_Shift_StartTime_EndTime >>>'
go

/* 
 * INDEX: AK_Shift_Name 
 */

CREATE UNIQUE INDEX AK_Shift_Name ON Shift(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Shift') AND name='AK_Shift_Name')
    PRINT '<<< CREATED INDEX Shift.AK_Shift_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Shift.AK_Shift_Name >>>'
go

/* 
 * INDEX: AK_ShipMethod_Name 
 */

CREATE UNIQUE INDEX AK_ShipMethod_Name ON ShipMethod(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('ShipMethod') AND name='AK_ShipMethod_Name')
    PRINT '<<< CREATED INDEX ShipMethod.AK_ShipMethod_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX ShipMethod.AK_ShipMethod_Name >>>'
go

/* 
 * INDEX: AK_ShipMethod_rowguid 
 */

CREATE UNIQUE INDEX AK_ShipMethod_rowguid ON ShipMethod(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('ShipMethod') AND name='AK_ShipMethod_rowguid')
    PRINT '<<< CREATED INDEX ShipMethod.AK_ShipMethod_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX ShipMethod.AK_ShipMethod_rowguid >>>'
go

/* 
 * INDEX: IX_ShoppingCartItem_ShoppingCartID_ProductID 
 */

CREATE INDEX IX_ShoppingCartItem_ShoppingCartID_ProductID ON ShoppingCartItem(ShoppingCartID, ProductID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('ShoppingCartItem') AND name='IX_ShoppingCartItem_ShoppingCartID_ProductID')
    PRINT '<<< CREATED INDEX ShoppingCartItem.IX_ShoppingCartItem_ShoppingCartID_ProductID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX ShoppingCartItem.IX_ShoppingCartItem_ShoppingCartID_ProductID >>>'
go

/* 
 * INDEX: AK_SpecialOffer_rowguid 
 */

CREATE UNIQUE INDEX AK_SpecialOffer_rowguid ON SpecialOffer(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SpecialOffer') AND name='AK_SpecialOffer_rowguid')
    PRINT '<<< CREATED INDEX SpecialOffer.AK_SpecialOffer_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SpecialOffer.AK_SpecialOffer_rowguid >>>'
go

/* 
 * INDEX: IX_SpecialOfferProduct_ProductID 
 */

CREATE INDEX IX_SpecialOfferProduct_ProductID ON SpecialOfferProduct(ProductID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SpecialOfferProduct') AND name='IX_SpecialOfferProduct_ProductID')
    PRINT '<<< CREATED INDEX SpecialOfferProduct.IX_SpecialOfferProduct_ProductID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SpecialOfferProduct.IX_SpecialOfferProduct_ProductID >>>'
go

/* 
 * INDEX: AK_SpecialOfferProduct_rowguid 
 */

CREATE UNIQUE INDEX AK_SpecialOfferProduct_rowguid ON SpecialOfferProduct(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('SpecialOfferProduct') AND name='AK_SpecialOfferProduct_rowguid')
    PRINT '<<< CREATED INDEX SpecialOfferProduct.AK_SpecialOfferProduct_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX SpecialOfferProduct.AK_SpecialOfferProduct_rowguid >>>'
go

/* 
 * INDEX: AK_StateProvince_rowguid 
 */

CREATE UNIQUE INDEX AK_StateProvince_rowguid ON StateProvince(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('StateProvince') AND name='AK_StateProvince_rowguid')
    PRINT '<<< CREATED INDEX StateProvince.AK_StateProvince_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX StateProvince.AK_StateProvince_rowguid >>>'
go

/* 
 * INDEX: AK_StateProvince_StateProvinceCode_CountryRegionCode 
 */

CREATE UNIQUE INDEX AK_StateProvince_StateProvinceCode_CountryRegionCode ON StateProvince(StateProvinceCode, CountryRegionCode)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('StateProvince') AND name='AK_StateProvince_StateProvinceCode_CountryRegionCode')
    PRINT '<<< CREATED INDEX StateProvince.AK_StateProvince_StateProvinceCode_CountryRegionCode >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX StateProvince.AK_StateProvince_StateProvinceCode_CountryRegionCode >>>'
go

/* 
 * INDEX: AK_StateProvince_Name 
 */

CREATE UNIQUE INDEX AK_StateProvince_Name ON StateProvince(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('StateProvince') AND name='AK_StateProvince_Name')
    PRINT '<<< CREATED INDEX StateProvince.AK_StateProvince_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX StateProvince.AK_StateProvince_Name >>>'
go

/* 
 * INDEX: IX_Store_SalesPersonID 
 */

CREATE INDEX IX_Store_SalesPersonID ON Store(SalesPersonID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Store') AND name='IX_Store_SalesPersonID')
    PRINT '<<< CREATED INDEX Store.IX_Store_SalesPersonID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Store.IX_Store_SalesPersonID >>>'
go

/* 
 * INDEX: AK_Store_rowguid 
 */

CREATE UNIQUE INDEX AK_Store_rowguid ON Store(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Store') AND name='AK_Store_rowguid')
    PRINT '<<< CREATED INDEX Store.AK_Store_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Store.AK_Store_rowguid >>>'
go

/* 
 * INDEX: IX_StoreContact_ContactID 
 */

CREATE INDEX IX_StoreContact_ContactID ON StoreContact(ContactID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('StoreContact') AND name='IX_StoreContact_ContactID')
    PRINT '<<< CREATED INDEX StoreContact.IX_StoreContact_ContactID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX StoreContact.IX_StoreContact_ContactID >>>'
go

/* 
 * INDEX: IX_StoreContact_ContactTypeID 
 */

CREATE INDEX IX_StoreContact_ContactTypeID ON StoreContact(ContactTypeID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('StoreContact') AND name='IX_StoreContact_ContactTypeID')
    PRINT '<<< CREATED INDEX StoreContact.IX_StoreContact_ContactTypeID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX StoreContact.IX_StoreContact_ContactTypeID >>>'
go

/* 
 * INDEX: AK_StoreContact_rowguid 
 */

CREATE UNIQUE INDEX AK_StoreContact_rowguid ON StoreContact(rowguid)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('StoreContact') AND name='AK_StoreContact_rowguid')
    PRINT '<<< CREATED INDEX StoreContact.AK_StoreContact_rowguid >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX StoreContact.AK_StoreContact_rowguid >>>'
go

/* 
 * INDEX: IX_TransactionHistory_ProductID 
 */

CREATE INDEX IX_TransactionHistory_ProductID ON TransactionHistory(ProductID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('TransactionHistory') AND name='IX_TransactionHistory_ProductID')
    PRINT '<<< CREATED INDEX TransactionHistory.IX_TransactionHistory_ProductID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX TransactionHistory.IX_TransactionHistory_ProductID >>>'
go

/* 
 * INDEX: IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID 
 */

CREATE INDEX IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID ON TransactionHistory(ReferenceOrderID, ReferenceOrderLineID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('TransactionHistory') AND name='IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID')
    PRINT '<<< CREATED INDEX TransactionHistory.IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX TransactionHistory.IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID >>>'
go

/* 
 * INDEX: IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID 
 */

CREATE INDEX IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID ON TransactionHistoryArchive(ReferenceOrderID, ReferenceOrderLineID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('TransactionHistoryArchive') AND name='IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID')
    PRINT '<<< CREATED INDEX TransactionHistoryArchive.IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX TransactionHistoryArchive.IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID >>>'
go

/* 
 * INDEX: IX_TransactionHistoryArchive_ProductID 
 */

CREATE INDEX IX_TransactionHistoryArchive_ProductID ON TransactionHistoryArchive(ProductID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('TransactionHistoryArchive') AND name='IX_TransactionHistoryArchive_ProductID')
    PRINT '<<< CREATED INDEX TransactionHistoryArchive.IX_TransactionHistoryArchive_ProductID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX TransactionHistoryArchive.IX_TransactionHistoryArchive_ProductID >>>'
go

/* 
 * INDEX: AK_UnitMeasure_Name 
 */

CREATE UNIQUE INDEX AK_UnitMeasure_Name ON UnitMeasure(Name)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('UnitMeasure') AND name='AK_UnitMeasure_Name')
    PRINT '<<< CREATED INDEX UnitMeasure.AK_UnitMeasure_Name >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX UnitMeasure.AK_UnitMeasure_Name >>>'
go

/* 
 * INDEX: AK_Vendor_AccountNumber 
 */

CREATE UNIQUE INDEX AK_Vendor_AccountNumber ON Vendor(AccountNumber)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('Vendor') AND name='AK_Vendor_AccountNumber')
    PRINT '<<< CREATED INDEX Vendor.AK_Vendor_AccountNumber >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX Vendor.AK_Vendor_AccountNumber >>>'
go

/* 
 * INDEX: IX_VendorAddress_AddressID 
 */

CREATE INDEX IX_VendorAddress_AddressID ON VendorAddress(AddressID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('VendorAddress') AND name='IX_VendorAddress_AddressID')
    PRINT '<<< CREATED INDEX VendorAddress.IX_VendorAddress_AddressID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX VendorAddress.IX_VendorAddress_AddressID >>>'
go

/* 
 * INDEX: IX_VendorContact_ContactTypeID 
 */

CREATE INDEX IX_VendorContact_ContactTypeID ON VendorContact(ContactTypeID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('VendorContact') AND name='IX_VendorContact_ContactTypeID')
    PRINT '<<< CREATED INDEX VendorContact.IX_VendorContact_ContactTypeID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX VendorContact.IX_VendorContact_ContactTypeID >>>'
go

/* 
 * INDEX: IX_VendorContact_ContactID 
 */

CREATE INDEX IX_VendorContact_ContactID ON VendorContact(ContactID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('VendorContact') AND name='IX_VendorContact_ContactID')
    PRINT '<<< CREATED INDEX VendorContact.IX_VendorContact_ContactID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX VendorContact.IX_VendorContact_ContactID >>>'
go

/* 
 * INDEX: IX_WorkOrder_ProductID 
 */

CREATE INDEX IX_WorkOrder_ProductID ON WorkOrder(ProductID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('WorkOrder') AND name='IX_WorkOrder_ProductID')
    PRINT '<<< CREATED INDEX WorkOrder.IX_WorkOrder_ProductID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX WorkOrder.IX_WorkOrder_ProductID >>>'
go

/* 
 * INDEX: IX_WorkOrder_ScrapReasonID 
 */

CREATE INDEX IX_WorkOrder_ScrapReasonID ON WorkOrder(ScrapReasonID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('WorkOrder') AND name='IX_WorkOrder_ScrapReasonID')
    PRINT '<<< CREATED INDEX WorkOrder.IX_WorkOrder_ScrapReasonID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX WorkOrder.IX_WorkOrder_ScrapReasonID >>>'
go

/* 
 * INDEX: IX_WorkOrderRouting_ProductID 
 */

CREATE INDEX IX_WorkOrderRouting_ProductID ON WorkOrderRouting(ProductID)
go
IF EXISTS (SELECT * FROM sys.indexes WHERE object_id=OBJECT_ID('WorkOrderRouting') AND name='IX_WorkOrderRouting_ProductID')
    PRINT '<<< CREATED INDEX WorkOrderRouting.IX_WorkOrderRouting_ProductID >>>'
ELSE
    PRINT '<<< FAILED CREATING INDEX WorkOrderRouting.IX_WorkOrderRouting_ProductID >>>'
go

