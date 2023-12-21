USE walmart;

DROP TABLE IF EXISTS `stores`;
DROP TABLE IF EXISTS `test`;
DROP TABLE IF EXISTS `train`;
DROP TABLE IF EXISTS `features`;

CREATE TABLE stores (
    Store INT PRIMARY KEY,
    Type VARCHAR(2),
    Size INT
);

CREATE TABLE test (
    Store INT,
    Dept INT,
    Date DATE,
    IsHoliday BOOLEAN,
    PRIMARY KEY (Store, Dept, Date)
);

CREATE TABLE train (
    Store INT,
    Dept INT,
    Date DATE,
    Weekly_Sales FLOAT,
    IsHoliday BOOLEAN,
    PRIMARY KEY (Store, Dept, Date)
);

CREATE TABLE features (
    Store INT,
    Date DATE,
    Temperature FLOAT,
    Fuel_Price FLOAT,
    MarkDown1 FLOAT,
    MarkDown2 FLOAT,
    MarkDown3 FLOAT,
    MarkDown4 FLOAT,
    MarkDown5 FLOAT,
    CPI FLOAT,
    Unemployment FLOAT,
    IsHoliday BOOLEAN,
    PRIMARY KEY (Store, Date)
);