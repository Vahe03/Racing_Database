-- 1. Find all the races where the chance of rain was at least 30%, along with the drivers that raced in it
SELECT DISTINCT r.Race_ID, d.First_Name, d.Last_Name, w.Chance_of_Rain
FROM driver d
JOIN driver_race dr ON d.Driver_ID = dr.Driver_ID
JOIN race r ON dr.Race_ID = r.Race_ID
JOIN weather_cond w ON r.Race_ID = w.Race_ID
WHERE w.Chance_of_Rain >= 30;


-- 2. Find all tracks located in Europe, along with the series that have races on those tracks.
SELECT DISTINCT t.Name AS Track_Name, c.Name AS Country, s.Name AS Series_Name
FROM track t
JOIN country c ON t.Country_ID = c.Country_ID
JOIN race r ON t.Track_ID = r.Track_ID
JOIN series s ON r.Series_ID = s.Series_ID
WHERE c.Continent = 'Europe';


-- 3. Calculate the average pit stop time for each driver in Formula 1.
SELECT d.First_Name, d.Last_Name, AVG(p.Duration) AS Avg_Pit_Stop_Time
FROM pit_stop p
JOIN driver d ON p.Driver_ID = d.Driver_ID
JOIN race r ON p.Race_ID = r.Race_ID
JOIN series s ON r.Series_ID = s.Series_ID
WHERE s.Name = 'Formula 1'
GROUP BY d.Driver_ID;


-- 4. Find all the races with less than 60 laps, along with the series, circuit and maximal temperatures.
SELECT r.Race_ID, s.Name AS Series, t.Name AS Track, r.Laps, w.Min_Temp, w.Max_Temp
FROM race r
JOIN weather_cond w ON r.Race_ID = w.Race_ID
JOIN series s ON r.Series_ID = s.Series_ID
JOIN track t ON r.Track_ID = t.Track_ID
WHERE r.Laps < 60;


-- 5. Find all races that took place in 2023, along with their series name and track location.
SELECT r.Race_ID, FROM_UNIXTIME(r.Date / 1000, '%Y-%m-%d'), s.Name AS Series_Name, t.Name AS Track_Name, c.Name AS Country
FROM race r
JOIN series s ON r.Series_ID = s.Series_ID
JOIN track t ON r.Track_ID = t.Track_ID
JOIN country c ON t.Country_ID = c.Country_ID
WHERE s.Year = 2023;


-- 6. Find the drivers who race for teams with sponsors founded before 1900.
SELECT 
    d.First_Name, 
    d.Last_Name, 
    t.Name AS Team_Name
FROM driver d
JOIN team t ON d.Team_ID = t.Team_ID
WHERE t.Team_ID IN (
    SELECT ts.Team_ID
    FROM team_sponsor ts
    JOIN sponsor s ON ts.Sponsor_ID = s.Sponsor_ID
    WHERE s.Founded_Year < 1900
);


-- 7. Find the races where the average pit stop duration is greater than the overall average pit stop duration
SELECT 
    r.Race_ID, 
    FROM_UNIXTIME(r.Date / 1000, '%Y-%m-%d') AS formatted_date, 
    t.Name AS Track_Name, 
    AVG(p.Duration) AS Avg_Pit_Stop
FROM race r
JOIN track t ON r.Track_ID = t.Track_ID
JOIN pit_stop p ON r.Race_ID = p.Race_ID
GROUP BY r.Race_ID
HAVING AVG(p.Duration) > (
    SELECT AVG(Duration) 
    FROM pit_stop
);


-- 8. Calculate the total pit stop time per team across all races, sorted by total time.
SELECT 
    t.Name AS Team_Name, 
    SUM(p.Duration) AS Total_PitStop_Time
FROM pit_stop p
JOIN driver d ON p.Driver_ID = d.Driver_ID
JOIN team t ON d.Team_ID = t.Team_ID
GROUP BY t.Team_ID
ORDER BY Total_PitStop_Time DESC;


-- 9. Calculate the total race distance covered in kilometers by each driver in 2023.
SELECT 
    d.First_Name, 
    d.Last_Name, 
    SUM(r.Laps * t.Length) AS Total_Distance_KM
FROM driver d
JOIN driver_race dr ON d.Driver_ID = dr.Driver_ID
JOIN race r ON dr.Race_ID = r.Race_ID
JOIN track t ON r.Track_ID = t.Track_ID
WHERE r.Series_ID IN (
    SELECT Series_ID
    FROM series
    WHERE Year = 2023
)
GROUP BY d.Driver_ID
ORDER BY Total_Distance_KM DESC;


-- 10. Find the races where the maximum temperature was above the average maximum temperature in all races.
SELECT 
    r.Race_ID,
    FROM_UNIXTIME(r.Date / 1000, '%Y-%m-%d'),
    t.Name AS Track_Name,
    wc.Max_Temp
FROM race r
JOIN weather_cond wc ON r.Race_ID = wc.Race_ID
JOIN track t ON r.Track_ID = t.Track_ID
WHERE wc.Max_Temp > (
    SELECT AVG(Max_Temp)
    FROM weather_cond
)
ORDER BY wc.Max_Temp DESC, r.Date;


-- Indexes.

-- 1. Index on pit_stop for fast lookup by driver and race.
CREATE INDEX idx_pitstop_driver_race ON pit_stop(Driver_ID, Race_ID);

-- 2. Index used to make it faster to join the race table with other tables.
CREATE INDEX idx_race_series_track ON race(Series_ID, Track_ID, Race_ID);

-- 3. Index on series for faster llokup by year.
CREATE INDEX idx_series_year ON series(Year);

-- 4. Index on Weather_Cond for faster filtering by chance of rain.
CREATE INDEX idx_chance_of_rain ON Weather_Cond(Chance_of_Rain);

-- 5. Index on Pit_Stop to quickly filter and aggregate data based on pit stop duration.
CREATE INDEX idx_pit_stop_duration ON Pit_Stop(Duration);

-- 6. Index on Series to speed up lookups by series name.
CREATE INDEX idx_series_name ON Series(Name);



-- Functions

-- 1. Function to get the fastest pit stop by driver.

DROP FUNCTION IF EXISTS get_fastest_pit_stop;
DROP FUNCTION IF EXISTS get_total_sponsors;
DROP FUNCTION IF EXISTS calculate_total_turns;


DELIMITER $$
CREATE FUNCTION get_fastest_pit_stop(driver_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE fastest_time DECIMAL(10, 2);
    SELECT MIN(Duration) INTO fastest_time
    FROM pit_stop
    WHERE Driver_ID = driver_id;
    RETURN COALESCE(fastest_time, 0);
END $$
DELIMITER ;


SELECT get_fastest_pit_stop(1) AS abc;

-- 2. Function to get the total number of sponsors for the given team.
DELIMITER $$
CREATE FUNCTION get_total_sponsors(team_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE sponsor_count INT;
    SELECT COUNT(*) INTO sponsor_count
    FROM team_sponsor
    WHERE Team_ID = team_id;
    RETURN sponsor_count;
END $$
DELIMITER ;

SELECT get_total_sponsors(1);

-- 3. Function to calculate the total number of turns in the given race.
DELIMITER $$

CREATE FUNCTION calculate_total_turns(race_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_turns INT;
    
    SELECT r.Laps * t.Num_of_Turns
    INTO total_turns
    FROM race r
    JOIN track t ON r.Track_ID = t.Track_ID
    WHERE r.Race_ID = race_id;
    
    RETURN total_turns;
END $$

DELIMITER ;

SELECT calculate_total_turns(1);



-- Views

-- 1. Sponsors with their associated teams and series.
CREATE VIEW SponsorTeamSeries AS
SELECT 
    s.Name AS Sponsor_Name,
    t.Name AS Team_Name,
    se.Name AS Series_Name
FROM sponsor s
JOIN team_sponsor ts ON s.Sponsor_ID = ts.Sponsor_ID
JOIN team t ON ts.Team_ID = t.Team_ID
JOIN team_series tse ON t.Team_ID = tse.Team_ID
JOIN series se ON tse.Series_ID = se.Series_ID;


-- 2. Total pitstop time for each driver.
CREATE VIEW driver_total_pitstop AS
SELECT 
    d.Driver_ID,
    CONCAT(d.First_Name, ' ', d.Last_Name) AS Driver_Name,
    SUM(p.Duration) AS Total_PitStop_Time
FROM driver d
JOIN pit_stop p ON d.Driver_ID = p.Driver_ID
GROUP BY d.Driver_ID;


-- 3. Number of times a race was held in each track.
CREATE VIEW track_usage AS
SELECT 
    t.Track_ID,
    t.Name AS Track_Name,
    c.Name AS Country,
    COUNT(r.Race_ID) AS Total_Races
FROM track t
JOIN race r ON t.Track_ID = r.Track_ID
JOIN country c ON t.Country_ID = c.Country_ID
GROUP BY t.Track_ID;