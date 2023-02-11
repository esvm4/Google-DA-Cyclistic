<h1 align="center">Case Study 1: Cyclistic</h1>

> Case Study: How Does a Bike-Share Navigate Speedy Success?\
> For more information: [Cyclistic Case Study](./Case1.pdf)

👤 **Thanh Ngoc** [@esvm4](https://github.com/esvm4)

📅 **Date:** 01 February, 2023

---

## Table of Contents

In this case study, I will break down the problem & solve it in 6 steps, recommended by Google as below:

1. [Ask](#ask)
   1. [Identify the problem you are trying to solve](#identify-the-problem-you-are-trying-to-solve)
   2. [Identify the stakeholders](#identify-the-stakeholders)
2. [Prepare](#prepare)
   1. [Where is your data located? How is the data organized?](#where-is-your-data-located-how-is-the-data-organized)
   2. [Are there issues with bias or credibility in this data? Does your data ROCCC?](#are-there-issues-with-bias-or-credibility-in-this-data-does-your-data-roccc)
   3. [How are you addressing licensing, privacy, security, and accessibility?](#how-are-you-addressing-licensing-privacy-security-and-accessibility)
   4. [How did you verify the data’s integrity?](#how-did-you-verify-the-datas-integrity)
   5. [How does it help you answer your question?](#how-does-it-help-you-answer-your-question)
   6. [Are there any problems with the data?](#are-there-any-problems-with-the-data)
3. [Process](#process)
   1. [What tools are you choosing and why?](#what-tools-are-you-choosing-and-why)
   2. [Have you ensured your data’s integrity?](#have-you-ensured-your-datas-integrity)
   3. [What steps have you taken to ensure that your data is clean?](#what-steps-have-you-taken-to-ensure-that-your-data-is-clean)
   4. [How can you verify that your data is clean and ready to analyze?](#how-can-you-verify-that-your-data-is-clean-and-ready-to-analyze)
4. [Analyse](#analyse)
   1. [What surprises did you discover in the data?](#what-surprises-did-you-discover-in-the-data)
   2. [What trends or relationships did you find in the data?](#what-trends-or-relationships-did-you-find-in-the-data)
   3. [How will these insights help answer your business questions?](#how-will-these-insights-help-answer-your-business-questions)
5. [Share](#share)
6. [Act](#act)

---

# Ask

- There is 2 main things needed to clarified in the Ask phase.

## Identify the problem you are trying to solve

- Identify the differences between annual members and casual riders.

## Identify the stakeholders

- Primary stakeholders: Lily Moreno, marketing analytics team
- Secondary stakeholders: Cyclistic executive team

# Prepare

- In this stage, we answer 6 questions:

## Where is your data located? How is the data organized?

- Data is downloaded from [Cyclistic's website](https://divvy-tripdata.s3.amazonaws.com/index.html) and stored in a folder named `Data` in the same directory as this notebook.
  Data is organised in 12 `.csv` files, each file contains data for a month in 2022.

## Are there issues with bias or credibility in this data? Does your data ROCCC?

- Reliable/Relevant: The data is publicly available and has been made available by Motivate International Inc. with the appropriate license. Second, the data is organised in a way that allows for easy analysis and has been checked for any issues with bias or credibility. The data has also been verified for integrity and is compliant with data-privacy regulations. Finally, the data is relevant to the questions of the case study, as it contains information related to how different customer types are using Cyclistic bikes.
- Original: The original data, has been downloaded directly from the [source](https://divvy-tripdata.s3.amazonaws.com/index.html) and not been modified in any way.
- Comprehensive: The data contains information related to how different customer types are using Cyclistic bikes, which will allow for a comprehensive analysis.
- Current: The data used is current, as it contains data from 12 months of 2022. Last updated is 03 January 2023.
- Cited: The data is cited, as it has been downloaded from the [source](https://divvy-tripdata.s3.amazonaws.com/index.html) and the source has been cited in the report.

## How are you addressing licensing, privacy, security, and accessibility?

- License, Security: The data is secure and publicly available and has been made available by Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement).
- Privacy: The data is compliant with data-privacy regulations.
  > ... note that data-privacy issues prohibit you from using riders’ personally identifiable information. This means that you won’t be able to connect pass purchases to credit card numbers to determine if casual riders live in the Cyclistic service area or if they have purchased multiple single passes.
- Accessibility: The data is accessible, as it is stored in a folder named `Data` in the same directory as this notebook.

## How did you verify the data’s integrity?

- Integrity checks can be found in **3.4** belown including
  - All data in the dataset has the same format
  - No duplications of data & primary key `ride_id` is unique
  - No null values
  - Both Casual & Member riders have 365 days of rides
  - Whether to keep or remove the outliers

## How does it help you answer your question?

- The dataset for each year contains 13 columns & the last column `casual_member`, which flags whether the rider is a casual rider or a member, is precisely the key to find the differences between the 2 groups.
- Potential differences the analysis may find are:
  - Duration of rides
  - Preferences of bike type
  - Usage trends in ride duration, ride frequency, and day of the week that rides are taken
  - The locations of popular stations and the most popular routes

## Are there any problems with the data?

- There are some problems with the dataset as below:
  - There are rides with duration less than 60s - which can be removed for [this reason](https://www.divvybikes.com/system-data)
  - There are rides with duration more than 24 hours - which can be removed for 2 reasons: [stolen bikes issues](https://help.divvybikes.com/hc/en-us/articles/360033123412-My-bike-was-lost-or-stolen) and [this issue](https://help.divvybikes.com/hc/en-us/articles/360033484791-What-if-I-keep-a-bike-out-too-long-)
  - Some rides have NULL station names - which can be removed for [this reason](https://divvybikes.com/system-data)
  - Some rides have TEST in their station names - which can be removed for [this reason](https://divvybikes.com/system-data)

# Process

- In this step, there are 4 main questions to be addressed:

## What tools are you choosing and why?

- I choose to work with SQL Server because it is a great free alternative to BigQuery to work with database. A copy of sql file will be placed in the same folder as this report under the name `Process.sql`.
- I also use Python in Jupyter notebook to clean data.

## Have you ensured your data’s integrity?

1. All data in the dataset must have the same format

- A data file consists of 13 colums, when be imported into SQL Server should be:
  - `ride_id`: VARCHAR(a)
  - `rideable_type`: VARCHAR(b)
  - `started_at`: DATETIME
  - `ended_at`: DATETIME
  - `start_station_name`: VARCHAR(c)
  - `start_station_id`: VARCHAR(d)
  - `end_station_name`: VARCHAR(e)
  - `end_station_id`: VARCHAR(f)
  - `start_lat`: DECIMAL(o, r)
  - `start_lng`: DECIMAL(p, s)
  - `end_lat`: FLOAT
  - `end_lng`: FLOAT
  - `member_casual`: VARCHAR(g)
- To find [a;g] and [o,r], I create a Python function to find the max length of 6 column in the dataset, to parse the number to `VARCHAR()` in `SQL` and a function to check if that column has the same max length in 12 files..

  ```python
  def getMaxLen(yr):
    if yr < 10:
        yr = '0' + str(yr)
    path = './Data/2022' + str(yr) + '-divvy-tripdata.csv'
    df = pd.read_csv(path)
    if df[col].dtype == 'object':
        return df[col].str.len().max()
    else:
        return df[col].astype(str).str.len().max()
  def checkSameMaxLen():
    for i in range(1, 12):
        for j in range(i+1, 13):
            if getMaxLen(i) != getMaxLen(j):
                return "12 columns of " + col + "do not have the same max length."
    return "12 columns of " +  col + " have the same max length."
  def getMaxLen12():
    max = 0
    for i in range(1, 13):
        if getMaxLen(i) > max:
            max = getMaxLen(i)
    return "Max length of column " + col + " is " + str(max)

  ```

- To find [r;s], I create a Python function to find min value and max value of 12 column in the dataset, to find the range of the column values.

  ```python
  def getMax(yr):
   if yr < 10:
       yr = '0' + str(yr)
   path = './Data/2022' + str(yr) + '-divvy-tripdata.csv'
   df = pd.read_csv(path)
   return  df[col].max()

  def getMax12():
     max = getMax(1)
     for i in range(2, 13):
         if getMax(i) > max:
             max = getMax(i)
     return "Max of column " + col + " is " + str(max)

  def getMin(yr):
     if yr < 10:
         yr = '0' + str(yr)
     path = './Data/2022' + str(yr) + '-divvy-tripdata.csv'
     df = pd.read_csv(path)
     return  df[col].min()

  def getMin12():
     min = getMin(1)
     for i in range(2, 13):
         if getMin(i) < min:
             min = getMin(i)
     return "Min of column " + col + " is " + str(min)
  ```

- **From these functions, I've come to these data types belove:**

  - `ride_id`: VARCHAR(16)
  - `rideable_type`: VARCHAR(13)
  - `started_at`: DATETIME
  - `ended_at`: DATETIME
  - `start_station_name`: VARCHAR(64)
  - `start_station_id`: VARCHAR(44)
  - `end_station_name`: VARCHAR(64)
  - `end_station_id`: VARCHAR(44)
  - `start_lat`: DECIMAL(18, 16)
  - `start_lng`: DECIMAL(18, 16)
  - `end_lat`: DECIMAL(18, 16)
  - `end_lng`: DECIMAL(18, 16)
  - `member_casual`: VARCHAR(6)

- We need to import all 12 data files into SQL Server, format columns, and join them as one table.

  - As 202209 → 202212 csv files have double quotes `""` in everything, which is not uniform with other files, I need to remove them first.

    ```python
    def removeFieldquote(yr):
      if yr < 10:
          yr = "0" + str(yr)
      path = "./Data/2022"+ str(yr) +"-divvy-tripdata.csv"
      with open(path, 'r') as f:
          reader = csv.reader(f)
          my_list = list(reader)
      for each in my_list:
          each[0] = each[0].replace('"', '')
      with open(path, 'w') as f:
          writer = csv.writer(f)
          writer.writerows(my_list)
    ```

  - Import 12 data files as tables into SQL Server as folow:
    ```sql
    -- create table
    CREATE TABLE [dbo].[tableName]
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
    )
    -- import data
    BULK INSERT [dbo].[tableName]
    FROM 'path\to\file.csv'
    WITH
    (
    CHECK_CONSTRAINTS,
    FIRSTROW = 2,
    TABLOCK,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
    );
    ```
  - Now that 12 tables have the same data format, we can join 12 tables into one:

    ```sql
    -- join all data
    INSERT INTO [dbo].[2022]
      SELECT * FROM [dbo].[202201]
      UNION ALL
      SELECT * FROM [dbo].[202202]
      UNION ALL
      ...
      SELECT * FROM [dbo].[202211]
      UNION ALL
      SELECT * FROM [dbo].[202212]
    ```

## What steps have you taken to ensure that your data is clean?

1. Wwe need to check for duplications

   ```sql
   -- check for ride_id duplications
   SELECT
    ride_id,
    COUNT(ride_id) AS appearances
   FROM [dbo].[2022]
   GROUP BY ride_id
   HAVING COUNT(ride_id) > 1
   ```

- From the result, we can see that there are no primary key duplications in the dataset.

2. Check for null and test values in the dataset.

- As the case doesn't state clearly whether test stations have "test" in their names or id, I may ask the data collector for more information. In this case, I remove all of them, to avoid any singularities.

  ```sql
  -- check for nulls and test stations,
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
  ```

- The results return (just show none 0 ones):
  | start_station_id_null | end_station_id_null | start_station_test | start_station_id_test | end_station_test | end_station_id_test |
  | --- | --- | --- | --- | --- | --- |
  | 833064 | 892742 | 1 | 2011 | 1 | 243 |

- Count rides with duration < 60s or > 24hrs → tne result returns 126449 rides

  ```sql
  -- count rides with duration < 60s or > 24hrs
  SELECT COUNT(ride_duration) FROM
  (SELECT * FROM
  	(SELECT DATEDIFF(SECOND, started_at, ended_at) AS ride_duration
  	FROM [dbo].[2022])
  AS TMP0
  WHERE ride_duration < 60 OR ride_duration > 24*60*60)
  AS TMP1
  ```

3. Filter out data that we have checked as above.

- To make it simpler, the final joined table is excluded 6 columns `start_station_name`, `start_lat`, `start_lng`, and `end_station_name`, `end_lat`, `end_lng` from the table as each 3 contains the same information as `start_station_id` and `end_station_id` respectively and included 1 more column `ride_duration` calculated from `started_at` and `ended_at`.

  ```sql
    -- succinct table: 7 columns
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

  ```

- From 5 667 717 rows of data, the succint table now has 4 291 293 rows, which means 24.3% of data was removed.

4. Ensure both Casual riders & Member have 365 days of rides

   ```sql
   -- Check if Casual riders & Members both have 365 days of rides
   SELECT member_casual, COUNT(DISTINCT start_date) AS dates_appeared FROM
   	(SELECT *, DATEADD(day, DATEDIFF(DAY, 0, started_at), 0) AS start_date
   	FROM [dbo].[succint2022])
   	AS TMP0
   GROUP BY member_casual
   ```

## How can you verify that your data is clean and ready to analyze?

- As all steps above can also be done in Python, I can use Python to verify the results. The code is in the file `Clean.ipynb` in the same folder as this report.
- About whether to keep outliners
  - Outliers (rides < 60s or > 24hrs) that are not suitable have been fully removed.
  - Any other outliers have been decided to be kept, because there're no reasons to eliminate them.

# Analyse

- The data is now clean and ready to be analysed. In this step, there are 5 questions to be addressed.
- All the analysis is done in Python under the file `Analyse.ipynb` in the same folder as this report.
- As the data in the succint2022 table has been cleaned, formatted and filtered out to keep just the information I need for this analysis, it is fine to say that I can skip the 2 first steps: organising and formatting.
  - How should you organize your data to perform analysis on it?
  - Has your data been properly formatted?

## What surprises did you discover in the data?

- There were no members who used docked bikes in 2022.
- Classic bikes were used 365 days by both, docked bikes were used 365 days by casual riders, meanwhile electrice bikes were used 364 days by both.
- Classic bikes seemed to be the most popular.
- Casual riders used bikes longer than members, in general.
- The most popular start station is Streeter Dr & Grand Ave for casual riders and all rides but it was Kingsbury St & Kinzie St among members.
- May-September were the most popular months for casual riders, while in January, February, and December, the business was slow.
- Around 16-18 in the evening, people were more likely to use bikes.

## What trends or relationships did you find in the data?

- Apart from the most popular station, the number of rides per station was not very different.
- Members really prefered to use classical bikes, the number nearly doubled that of casual riders.
- Bike usage went up to reach peak in the summer, then went down in the winter, making its usage an U-shaped curve.

## How will these insights help answer your business questions?

Those insights above can help me answer the differences between members and casual riders as below:

- Members prefered Kingsbury St & Kinzie while casual riders preferred Streeter Dr & Grand Ave. This may happened due to the lack of marketing about the benefits of a membership in the area of Streeter Dr & Grand Ave.
- Although the numbers are low, members still chose to use the service in Jan, Feb, Nov and Dec, making up for 3/4 of the usage in those months. This may be due to the fact that casual riders are more likely to use bikes for leisure, while members are more likely to use bikes for commuting to work.
- The same goes for the time of day, members were more likely to use bikes for commuting to work in the morning at 7-8, while casual riders didn't it that much.

# Share

All the images of the results are stored in the file `Analyse.ipynb` in the same folder as this report.

# Act

Based on those insights, I would recommend the following actions to the company:

- Market the benefits of a membership in the area of Streeter Dr & Grand Ave.
- Casual riders that used bikes 7-8 a.m or in Jan, Feb, Nov and Dec should be encouraged to become members. The company should actively reach out to them to offer them a membership, especially a trial one.
- The usage of docked bikes were low in both groups, perhaps the company didn't place many docked bikes or people actually didn't like docked bikes. Either way, the company should do something further about the numbers of docked bikes and classical bikes.
