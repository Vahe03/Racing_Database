INSERT IGNORE INTO country (Country_ID, Name, Continent) VALUES
(1, 'United States', 'North America'),
(2, 'United Kingdom', 'Europe'),
(3, 'Japan', 'Asia'),
(4, 'Australia', 'Australia'),
(5, 'Germany', 'Europe');


INSERT IGNORE INTO track (Track_ID, Name, Length, Num_of_Turns, Country_ID) VALUES
(1, 'Silverstone Circuit', 5.89, 18, 2),
(2, 'Suzuka Circuit', 5.81, 18, 3),
(3, 'Circuit of the Americas', 5.51, 20, 1),
(4, 'Nürburgring', 5.15, 16, 5),
(5, 'Albert Park Circuit', 5.30, 14, 4);


INSERT IGNORE INTO series (Series_ID, Name, Year) VALUES
(1, 'Formula 1', 2023),
(2, 'Formula E', 2022),
(3, 'MotoGP', 2023),
(4, 'World Endurance Championship (WEC)', 2023),
(5, 'NASCAR Cup Series', 2022),
(6, 'Formula 1', 2022);



INSERT IGNORE INTO team (Team_ID, Name, Country_ID, Founded_Year) VALUES
(1, 'Red Bull Racing', 2, 2005),
(2, 'Mercedes-AMG', 5, 2010),
(3, 'Scuderia Ferrari', 5, 1929),
(4, 'McLaren', 2, 1963),
(5, 'AlphaTauri', 2, 2020),
(6, 'Ducati', 1, 1993),
(7, 'Rebellion Racing', 5, 2007),
(8, 'Hendrick Motorsports', 1, 1984);


INSERT IGNORE INTO driver (Driver_ID, First_Name, Last_Name, DOB, Country_ID, Team_ID) VALUES
(1, 'Max', 'Verstappen', '1997-09-30', 5, 1),
(2, 'Lewis', 'Hamilton', '1985-01-07', 2, 2),
(3, 'Marc', 'Marquez', '1993-02-17', 3, 6),
(4, 'Fernando', 'Alonso', '1981-07-29', 2, 4),
(5, 'Chase', 'Elliott', '1995-11-28', 1, 8);


INSERT IGNORE INTO race (Race_ID, Date, Laps, Track_ID, Series_ID) VALUES
(1, '2023-07-09', 52, 1, 1), -- Formula 1
(2, '2022-03-15', 45, 2, 2), -- Formula E
(3, '2023-05-01', 60, 3, 3), -- MotoGP
(4, '2023-06-12', 72, 4, 4), -- WEC
(5, '2022-11-20', 200, 5, 5), -- NASCAR Cup Series
(6, '2023-10-01', 53, 2, 1), -- Formula 1
(7, '2022-04-10', 58, 1, 6), -- Formula 1
(8, '2022-07-17', 52, 2, 6); -- Formula 1

INSERT IGNORE INTO weather_cond (Race_ID, Max_Temp, Min_Temp, Chance_of_Rain) VALUES
(1, 30.5, 20.3, 10.0),
(6, 25.0, 18.0, 50.0),
(2, 22.0, 15.0, 70.0),
(3, 28.0, 18.0, 0.0),
(4, 24.5, 16.2, 30.0),
(5, 31.0, 22.0, 5.0),
(6, 25.0, 18.0, 50.0),
(7, 28.0, 18.0, 10.0),
(8, 30.0, 20.0, 5.0);

INSERT IGNORE INTO sponsor (Sponsor_ID, Name, Founded_Year) VALUES
(1, 'Red Bull', 1987),          
(2, 'Petronas', 1974),          
(3, 'Shell', 1907),             
(4, 'Ducati', 1926),            
(5, 'Michelin', 1889),          
(6, 'Monster Energy', 2002),    
(7, 'Hewlett-Packard', 1939),   
(8, 'Pirelli', 1872),           
(9, 'Amazon Web Services', 2006);


INSERT IGNORE INTO driver_race (Driver_ID, Race_ID)
VALUES
-- Formula 1
(1, 1),
(2, 1),
(4, 1),
(1, 6),
(2, 6),
(4, 6),
(1, 7),
(2, 7),
(4, 7),
(1, 8),
(2, 8),
(4, 8),

-- MotoGP
(3, 3),
(6, 3),

-- WEC
(1, 4),
(4, 4),

-- NASCAR Cup Series
(2, 5),
(5, 5);



INSERT IGNORE INTO team_series (Team_ID, Series_ID) VALUES
-- Formula 1
(1, 1), -- Red Bull Racing (2023)
(2, 1), -- Mercedes-AMG (2023)
(3, 1), -- Scuderia Ferrari (2023)
(4, 1), -- McLaren (2023)
(1, 6), -- Red Bull Racing (2022)
(2, 6), -- Mercedes-AMG (2022)
(3, 6), -- Scuderia Ferrari (2022)
(4, 6), -- McLaren (2022)

-- Formula E
(5, 2), -- AlphaTauri
(3, 2), -- Scuderia Ferrari

-- MotoGP
(3, 3), -- Scuderia Ferrari
(6, 3), -- Ducati

-- WEC
(1, 4), -- Red Bull Racing
(7, 4), -- Rebellion Racing
(4, 4), -- McLaren

-- NASCAR Cup Series
(8, 5), -- Hendrick Motorsports
(5, 5), -- AlphaTauri
(2, 5); -- Mercedes-AMG



INSERT IGNORE INTO team_race (Team_ID, Race_ID) VALUES
-- Formula 1 (2023)
(1, 1), -- Red Bull Racing
(2, 1), -- Mercedes-AMG
(3, 1), -- Scuderia Ferrari
(4, 1), -- McLaren
(1, 6), -- Red Bull Racing
(2, 6), -- Mercedes-AMG
(3, 6), -- Scuderia Ferrari

-- Formula E
(5, 2), -- AlphaTauri

-- MotoGP
(3, 3), -- Scuderia Ferrari
(6, 3), -- Ducati

-- WEC
(1, 4), -- Red Bull Racing
(7, 4), -- Rebellion Racing
(4, 4), -- McLaren

-- NASCAR
(8, 5), -- Hendrick Motorsports
(5, 5), -- AlphaTauri
(2, 5), -- Mercedes-AMG

-- Formula 1 (2022)
(1, 7), -- Red Bull Racing
(2, 7), -- Mercedes-AMG
(3, 7), -- Scuderia Ferrari
(4, 7), -- McLaren
(1, 8), -- Red Bull Racing
(2, 8), -- Mercedes-AMG
(3, 8), -- Scuderia Ferrari
(4, 8); -- McLaren


INSERT IGNORE INTO pit_stop (PitStop_ID, Driver_ID, Race_ID, Lap, Duration) VALUES
-- Formula 1 (2023)
(1, 1, 1, 12, 2.50),
(2, 1, 1, 40, 2.45),
(3, 2, 1, 15, 2.60),
(4, 4, 1, 38, 2.70),

-- Formula 1 (2022)
(5, 1, 7, 10, 2.48),
(6, 1, 7, 35, 2.50),
(7, 2, 7, 14, 2.55),
(8, 4, 7, 36, 2.63),

-- NASCAR (2022)
(9, 5, 5, 20, 5.00),
(10, 5, 5, 50, 5.10),

-- WEC (2023)
(11, 4, 4, 25, 10.25),
(12, 7, 4, 50, 12.30);

INSERT IGNORE INTO team_sponsor (Team_ID, Sponsor_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 8),
(5, 6),
(6, 7),
(6, 4),
(7, 5),
(1, 9),
(7, 4),
(8, 6),
(8, 5),
(5, 9),
(4, 6);
