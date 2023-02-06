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

## What steps have you taken to ensure that your data is clean?

## How can you verify that your data is clean and ready to analyze?

# Analyse

# Share

# Act
