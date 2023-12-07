# Gender Equality Data Analysis for Côte d'Ivoire (Using SQL)

### table of content 
- [Project Overview](#project-overview)
- [Data Source](#data-source)
- [Tools](#tools)
- [Explore data analysis](#explore-data-analysis)
- [Data Analysis](#data-analysis)

### project overview
This SQL script is part of a data analysis project that explores various gender equality indicators in Côte d'Ivoire. The purpose of the script is to extract and manipulate data for further analysis and visualization.

### Data Source
- Source: World Bank Open Data
- URL: (https://data.worldbank.org/country/CI)]

### Tools
- Excel for data cleaning.
- Mysql for analysis.
- PoweBi for creating a report.

### Explore data analysis
- Aggregates data for educational attainment among adults over 25 by gender:
 - calculating a rounded average of the completion rates across different levels of education for the years 1998, 2014, and 2016.
Child Education Gap Analysis
- Examines the gender gap in child education.
- Gathers literacy rate data for adults over 15:
 - differentiating between males and females, to observe trends over the available years.
Labor Force Participation Rate Examination.
- Analyzes the labor force participation rate for the population over 15 years old,segregated by gender.
- Compares the legal rights and status of women in 2010 versus 2020 across various indicators.
- Selects data on the percentage of women who believe a husband is justified in beating his wife under specific circumstances, reflecting societal attitudes towards domestic violence.
Employment Metrics for Women
- Collects data from 2020 on different employment metrics for women
- Chooses relevant data for visualization in a dashboard, focusing on key indicators from 2015 to 2022, such as maternal death risk, prenatal care, life expectancy, and retirement age with full benefits.
  
### Data Analysis  

##### 1- Gendered Education Completion Rates for Adults Over 25 (1998-2016)
###### SQL Query
```sql
SELECT 
    'Educational_attainment_Above25' AS Indicator,
    Year,
    ROUND(((
        MAX(CASE WHEN Indicator_Name = 'Educational attainment, at least completed primary, population 25+ years, female (%) (cumulative)' THEN Value END)
        + MAX(CASE WHEN Indicator_Name = 'Educational attainment, at least completed lower secondary, population 25+, female (%) (cumulative)' THEN Value END)
        + MAX(CASE WHEN Indicator_Name = 'Educational attainment, at least completed post-secondary, population 25+, female (%) (cumulative)' THEN Value ELSE 7 END)
        + MAX(CASE WHEN Indicator_Name = 'Educational attainment, at least completed upper secondary, population 25+, female (%) (cumulative)' THEN Value END)
    ) * 100 / 400), 2) AS Female,
    ROUND(((
        MAX(CASE WHEN Indicator_Name = 'Educational attainment, at least completed primary, population 25+ years, male (%) (cumulative)' THEN Value END)
        + MAX(CASE WHEN Indicator_Name = 'Educational attainment, at least completed lower secondary, population 25+, male (%) (cumulative)' THEN Value END)
        + MAX(CASE WHEN Indicator_Name = 'Educational attainment, at least completed post-secondary, population 25+, male (%) (cumulative)' THEN Value ELSE 10 END)
        + MAX(CASE WHEN Indicator_Name = 'Educational attainment, at least completed upper secondary, population 25+, male (%) (cumulative)' THEN Value END)
    ) * 100 / 400), 2) AS Male
FROM gender_civ
WHERE Indicator_Name IN (
    'Educational attainment, at least completed primary, population 25+ years, female (%) (cumulative)',
    'Educational attainment, at least completed primary, population 25+ years, male (%) (cumulative)',
    'Educational attainment, at least completed lower secondary, population 25+, female (%) (cumulative)',
    'Educational attainment, at least completed lower secondary, population 25+, male (%) (cumulative)',
    'Educational attainment, at least completed post-secondary, population 25+, female (%) (cumulative)',
    'Educational attainment, at least completed post-secondary, population 25+, male (%) (cumulative)',
    'Educational attainment, at least completed upper secondary, population 25+, female (%) (cumulative)',
    'Educational attainment, at least completed upper secondary, population 25+, male (%) (cumulative)'
) AND Year IN (1998, 2014, 2016)
GROUP BY Indicator, Year;
```
###### Analysis Results

![Gendered Education Completion Rates for Adults Over 25 (1998-2016)](https://github.com/MoazWael2/Moaz_portfolio/assets/137816418/730f77dd-164e-4b79-99b3-caeb4da0ecdc)

###### Findings
- Increase in Male Educational Attainment: There is a significant increase in the percentage of males over 25 with completed education from 1998 to 2014.
- Stagnation in Female Educational Attainment: Female education completion rates show a small increase between 1998 and 2014 but remain unchanged between 2014 and 2016. This indicates that the advancements made in female education might be facing certain challenges or reaching a plateau.
- Gender Disparity: In 1998 and 2016, females had lower completion rates compared to males, which highlights a persistent gender gap in education.
- 
###### Recommendations
- Enhanced Educational Initiatives for Women: Prioritize and amplify educational programs for adult women to boost completion rates. This could involve providing scholarships, creating awareness campaigns, and developing adult education centers focused on female education.

##### 2- Analysis of Evolving Gender Gaps in Child Education 'children out of school ' (1977-2022)
######  SQL Query
The following SQL query aims to analyze the evolving gender gaps in child education by examining the number of children out of school at the primary level. The data spans from 1977 to 2022 and is separated by gender to provide insights into disparities and trends over time.

```sql
-- This query selects the number of children out of school at the primary level, 
-- grouped by year and gender, providing a year-over-year overview of the gender gap in education.

SELECT 
    'Child_out_School' AS Indicator,
    Year,
    ROUND(MAX(CASE WHEN Indicator_Name = 'Children out of school, primary, female' THEN Value END), 2) AS Female,
    ROUND(MAX(CASE WHEN Indicator_Name = 'Children out of school, primary, male' THEN Value END), 2) AS Male
FROM 
    gender_civ
WHERE 
    Indicator_Name IN (
        'Children out of school, primary, male', 
        'Children out of school, primary, female'
    )
GROUP BY 
    Year
ORDER BY 
    Year;
```

###### Analysis Results
![children's out school](https://github.com/MoazWael2/Moaz_portfolio/assets/137816418/6ee46b7f-c7d5-47e4-bf9f-33d24d50cdbe)

###### Findings
- Trends Over Time: The chart shows fluctuations in the number of children out of school, with notable peaks and declines. For both genders, there was a peak around the year 2009, followed by a significant decline.
- Gender Disparity: Throughout the years, female children out of school outnumbered male children, especially during the peak around 2009. However, the gap narrows in more recent years as the numbers decline.
- Recent Improvements: The downward trend since 2009 is promising and suggests improvements in educational access or policies that have reduced the number of children out of school.

###### Recommendations
- Continue Successful Policies: Reinforce the policies and initiatives that have contributed to the declining trend of children out of school since 2009.


###### Analysis Results
###### Findings
###### Recommendations
