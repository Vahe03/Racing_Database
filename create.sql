CREATE DATABASE RacingDB;
USE RacingDB;

DROP TABLE IF EXISTS Team_Series;
DROP TABLE IF EXISTS Team_Race;
DROP TABLE IF EXISTS Driver_Race;
DROP TABLE IF EXISTS Team_Sponsor;
DROP TABLE IF EXISTS Weather_Cond;
DROP TABLE IF EXISTS Sponsor;
DROP TABLE IF EXISTS Pit_stop;
DROP TABLE IF EXISTS Race;
DROP TABLE IF EXISTS Track;
DROP TABLE IF EXISTS Driver;
DROP TABLE IF EXISTS Team;
DROP TABLE IF EXISTS Country;
DROP TABLE IF EXISTS Series;
DROP TABLE IF EXISTS Team_Sponsor;


CREATE TABLE Country (
    Country_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Continent VARCHAR(100)
);

CREATE TABLE Track (
    Track_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Length DECIMAL(5, 2),
    Num_of_Turns INT,
    Country_ID INT NOT NULL,
    FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID)
);

CREATE TABLE Series (
    Series_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Year YEAR
);

CREATE TABLE Race (
    Race_ID INT PRIMARY KEY,
    Date DATE NOT NULL,
    Laps INT,
    Track_ID INT NOT NULL,
    Series_ID INT NOT NULL,
    FOREIGN KEY (Track_ID) REFERENCES Track(Track_ID),
    FOREIGN KEY (Series_ID) REFERENCES Series(Series_ID)
);

CREATE TABLE Weather_Cond (
    Race_ID INT NOT NULL,
    Max_temp DECIMAL(4, 1) NOT NULL,
    Min_temp DECIMAL(4, 1) NOT NULL,
    Chance_of_Rain DECIMAL(4, 1) NOT NULL,
    PRIMARY KEY (Race_ID, Max_temp, Min_temp, Chance_of_Rain),
    FOREIGN KEY (Race_ID) REFERENCES Race(Race_ID)
);

CREATE TABLE Team (
    Team_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Founded_year YEAR,
    Country_ID INT NOT NULL,
    FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID)
);

CREATE TABLE Driver (
    Driver_ID INT PRIMARY KEY,
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    DOB DATE,
    Country_ID INT NOT NULL,
    Team_ID INT NOT NULL,
    FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID),
    FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID)
);

CREATE TABLE Sponsor (
    Sponsor_ID INT NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Founded_year INT
);

CREATE TABLE Team_Sponsor (
    Team_ID INT NOT NULL,
    Sponsor_ID INT NOT NULL,
    PRIMARY KEY (Team_ID, Sponsor_ID),
    FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID),
    FOREIGN KEY (Sponsor_ID) REFERENCES Sponsor(Sponsor_ID)
);

CREATE TABLE Team_Series (
    Team_ID INT NOT NULL,
    Series_ID INT NOT NULL,
    PRIMARY KEY (Team_ID, Series_ID),
    FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID),
    FOREIGN KEY (Series_ID) REFERENCES Series(Series_ID)
);

CREATE TABLE Driver_Race (
    Driver_ID INT NOT NULL,
    Race_ID INT NOT NULL,
    PRIMARY KEY (Driver_ID, Race_ID),
    FOREIGN KEY (Driver_ID) REFERENCES Driver(Driver_ID),
    FOREIGN KEY (Race_ID) REFERENCES Race(Race_ID)
);

CREATE TABLE Team_Race (
    Team_ID INT NOT NULL,
    Race_ID INT NOT NULL,
    PRIMARY KEY (Team_ID, Race_ID),
    FOREIGN KEY (Team_ID) REFERENCES Team(Team_ID),
    FOREIGN KEY (Race_ID) REFERENCES Race(Race_ID)
);

CREATE TABLE Pit_stop (
    PitStop_ID INT PRIMARY KEY,
    Driver_ID INT,
    Race_ID INT,
    Lap INT,
    Duration DECIMAL(5, 2),
    FOREIGN KEY (Driver_ID) REFERENCES driver(Driver_ID),
    FOREIGN KEY (Race_ID) REFERENCES race(Race_ID)
);