create database divvytrip

-- create table for each csv file
USE divvytrip;
GO
CREATE TABLE [dbo].[202212]
(
    ride_id VARCHAR(16) NOT NULL,
    rideable_type VARCHAR(13),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(64),
    start_station_id VARCHAR(44),
	end_station_name VARCHAR(64),
    end_station_id VARCHAR(44),
	start_lat DECIMAL(18, 16),
	start_lng DECIMAL(18, 16),
	end_lat DECIMAL(18, 16),
	end_lng DECIMAL(18, 16),
    member_casual CHAR(6),
    CONSTRAINT [PK_202212] PRIMARY KEY CLUSTERED
    (
        [ride_id] ASC
    )
);


-- import csv file
BULK INSERT [dbo].[202212]
FROM 'E:\divvytrip\202212.csv'
WITH
(
	CHECK_CONSTRAINTS,
    FIRSTROW = 2,
    TABLOCK,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

-- join as one table
CREATE TABLE [dbo].[succint2022]
(
    ride_id VARCHAR(16) NOT NULL,
    rideable_type VARCHAR(13),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(64),
    start_station_id VARCHAR(44),
	end_station_name VARCHAR(64),
    end_station_id VARCHAR(44),
	start_lat DECIMAL(18, 16),
	start_lng DECIMAL(18, 16),
	end_lat DECIMAL(18, 16),
	end_lng DECIMAL(18, 16),
    member_casual CHAR(6)
);

INSERT INTO [dbo].[2022]
SELECT * FROM [dbo].[202201]
UNION ALL
SELECT * FROM [dbo].[202202]
UNION ALL
SELECT * FROM [dbo].[202203]
UNION ALL
SELECT * FROM [dbo].[202204]
UNION ALL
SELECT * FROM [dbo].[202205]
UNION ALL
SELECT * FROM [dbo].[202206]
UNION ALL
SELECT * FROM [dbo].[202207]
UNION ALL
SELECT * FROM [dbo].[202208]
UNION ALL
SELECT * FROM [dbo].[202209]
UNION ALL
SELECT * FROM [dbo].[202210]
UNION ALL
SELECT * FROM [dbo].[202211]
UNION ALL
SELECT * FROM [dbo].[202212]


-- check for ride_id duplications
SELECT ride_id, COUNT(ride_id) AS appearances
FROM [dbo].[2022]
GROUP BY ride_id
HAVING COUNT(ride_id) > 1

-- check for nulls, test stations
SELECT
	SUM(CASE WHEN ride_id IS NULL THEN 1 ELSE 0 END) AS ride_id_null,
	SUM(CASE WHEN rideable_type IS NULL THEN 1 ELSE 0 END) AS rideable_type_null,
	SUM(CASE WHEN started_at IS NULL THEN 1 ELSE 0 END) AS started_at_null,
	SUM(CASE WHEN ended_at IS NULL THEN 1 ELSE 0 END) AS ended_at_null,
	SUM(CASE WHEN start_station_id IS NULL THEN 1 ELSE 0 END) AS start_station_id_null,
	SUM(CASE WHEN end_station_id IS NULL THEN 1 ELSE 0 END) AS end_station_id_null,
	SUM(CASE WHEN member_casual IS NULL THEN 1 ELSE 0 END) AS member_casual_null,
	SUM(CASE WHEN start_station_name LIKE '%TEST%' THEN 1 ELSE 0 END) AS start_station_test,
	SUM(CASE WHEN start_station_id LIKE '%TEST%' THEN 1 ELSE 0 END) AS start_station_id_test,
	SUM(CASE WHEN end_station_name LIKE '%TEST%' THEN 1 ELSE 0 END) AS end_station_test,
	SUM(CASE WHEN end_station_ID LIKE '%TEST%' THEN 1 ELSE 0 END) AS end_station_id_test
FROM [dbo].[2022]

SELECT COUNT(ride_duration) FROM
	(SELECT * FROM
		(SELECT DATEDIFF(SECOND, started_at, ended_at) AS ride_duration
		FROM [dbo].[2022])
	AS TMP0
	WHERE ride_duration < 60 OR ride_duration > 24*60*60)
	AS TMP1



-- copy eligible data into succint2022 table
SELECT
	ride_id, rideable_type,
	started_at, ended_at, DATEDIFF(SECOND, started_at, ended_at) AS ride_duration,
	start_station_id, end_station_id, member_casual
INTO [dbo].[succint2022]
FROM [dbo].[2022]
WHERE
	start_station_id IS NOT NULL
	AND
	end_station_id IS NOT NULL
	AND
	start_station_name NOT LIKE '%TEST'
	AND
	start_station_id NOT LIKE '%TEST'
	AND
	end_station_name NOT LIKE '%TEST'
	AND
	end_station_id NOT LIKE '%TEST'
	AND
	DATEDIFF(SECOND, started_at, ended_at) > 60
	AND
	DATEDIFF(SECOND, started_at, ended_at) < 24*60*60


-- Check if Casual riders & Members both have 365 days of rides
SELECT member_casual, COUNT(DISTINCT start_date) AS dates_appeared FROM
	(SELECT *, DATEADD(day, DATEDIFF(DAY, 0, started_at), 0) AS start_date
	FROM [dbo].[succint2022])
	AS TMP0
GROUP BY member_casual