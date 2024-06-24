-- I used table name as Corona_data instead of original_name.

Select *
from Corona_data
order by date

----------------------------1
SELECT *
FROM Corona_data
WHERE province IS NULL;

----------------------------2
update corona_data set confirmed = 0 where confirmed is null

----------------------------3
Select count(*) as Total_rows
from corona_data

----------------------------4
Select cast(min(date) as date) as start_date , cast(max(date) as date) as end_date
from corona_data

----------------------------5
Select count(distinct(left(date,7))) as Num_of_mth
from corona_data
order by Num_of_mth

---------------------------6
Select month(date) as Month, year(date) as Year, sum(Confirmed) AS AverageConfirmed,AVG(Deaths) AS AverageDeaths,AVG(Recovered) AS AverageRecovered
from Corona_Data
group by month(date) ,year(date)
order by year(date), month(date) 

---------------------------7

WITH MostFrequentValues AS (
    SELECT
        YEAR(Date) AS Year,
        MONTH(Date) AS Month,
        Confirmed,
        Deaths,
        Recovered,
        ROW_NUMBER() OVER (PARTITION BY YEAR(Date), MONTH(Date) ORDER BY COUNT(Confirmed) DESC) AS ConfirmedRank,
        ROW_NUMBER() OVER (PARTITION BY YEAR(Date), MONTH(Date) ORDER BY COUNT(Deaths) DESC) AS DeathsRank,
        ROW_NUMBER() OVER (PARTITION BY YEAR(Date), MONTH(Date) ORDER BY COUNT(Recovered) DESC) AS RecoveredRank
    FROM
        Corona_Data
    GROUP BY
        YEAR(Date),
        MONTH(Date),
        Confirmed,
        Deaths,
        Recovered
)

SELECT
    Year,
    Month,
    Confirmed AS MostFrequentConfirmed,
    Deaths AS MostFrequentDeaths,
    Recovered AS MostFrequentRecovered
FROM
    MostFrequentValues
WHERE
    ConfirmedRank = 1 AND DeathsRank = 1 AND RecoveredRank = 1
ORDER BY
    Year,
    Month;


---------------------------8
Select year(date) as years, min(confirmed) as con , min(deaths) as dth , min(recovered) as red
from corona_data
group by year(date)
order by year(date)

---------------------------9
Select year(date) as years, max(confirmed) as con , max(deaths) as dth , max(recovered) as red
from corona_data
group by year(date)
order by year(date)

---------------------------10
Select month(date) as Month, year(date) as Year, sum(Confirmed) AS AverageConfirmed,sum(Deaths) AS AverageDeaths,sum(Recovered) AS AverageRecovered
from Corona_Data
group by month(date) ,year(date)
order by year(date), month(date) 

---------------------------11
SELECT
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Confirmed) AS TotalConfirmedCases,
    AVG(Confirmed) AS AverageConfirmedCases,
    VAR(Confirmed) AS VarianceConfirmedCases,
    STDEV(Confirmed) AS StandardDeviationConfirmedCases
FROM
    Corona_Data
GROUP BY
    YEAR(Date),
    MONTH(Date)
ORDER BY
    Year,
    Month;

---------------------------12
SELECT
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    SUM(Deaths) AS TotalDeathCases,
    AVG(Deaths) AS AverageDeathCases,
    VAR(Deaths) AS VarianceDeathCases,
    STDEV(Deaths) AS StandardDeviationDeathCases
FROM
    Corona_Data
GROUP BY
    YEAR(Date),
    MONTH(Date)
ORDER BY
    Year,
    Month;

---------------------------13
Select month(date) as month, year(date) as year, avg(recovered) as recovered_cases, var(Recovered) as Variance_cases, STDEV(recovered) as Standard_Dev_cases
from Corona_Data
group by month(date),year(date)
order by year,month

---------------------------14
with cte as (
Select [Country/Region] as country, Sum(confirmed) as Hgh_con_cases 
from corona_data
group by [Country/Region]

)
Select country, Hgh_con_cases 
from cte
where Hgh_con_cases = (Select max(Hgh_con_cases) from cte) 

---------------------------15
with cte as (
Select [Country/Region] as country, Sum([deaths]) as Low_num_dth_cases 
from corona_data
group by [Country/Region]

)
Select country, Low_num_dth_cases 
from cte
where Low_num_dth_cases = (Select min(Low_num_dth_cases) from cte) 

---------------------------16
Select top 5 [country/Region] as country, sum(recovered) as Reov_cases
from Corona_data
group by [country/Region] 
order by Reov_cases desc









































