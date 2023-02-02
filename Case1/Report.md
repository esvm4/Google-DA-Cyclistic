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
  - No singularities in the dataset
  - No duplications of data & primary key `ride_id` is unique
  - Both Casual & Member riders have 365 days of rides

## How does it help you answer your question?

- The dataset for each year contains 13 columns & the last column `casual_member`, which flags whether the rider is a casual rider or a member, is precisely the key to find the differences between the 2 groups.
- Potential differences the analysis may find are:
  - Duration of rides
  - Preferences of bike type
  - Usage trends in ride duration, ride frequency, and day of the week that rides are taken
  - The locations of popular stations and the most popular routes

## Are there any problems with the data?

# Process

- In this step, there are 4 main questions to be addressed:

## What tools are you choosing and why?

## Have you ensured your data’s integrity?

## What steps have you taken to ensure that your data is clean?

## How can you verify that your data is clean and ready to analyze?

# Analyse

# Share

# Act
