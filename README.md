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

##### 3- Evolution of Literacy Rates Among Adults Over 15 in Côte d'Ivoire  (1977-2022)
###### SQL Query
This SQL query is part of an analysis exploring literacy rates among the adult population over the age of 15 in Côte d'Ivoire, segmented by gender. The goal is to track changes in literacy rates over time to understand educational progress and identify gaps between genders.
```sql
-- Retrieves the literacy rate values for adult males and females over the age of 15 for each year
-- to understand the evolution of literacy in Côte d'Ivoire.

SELECT 
    'Literacy rate% Above 15' AS Indicator,
    Year,
    ROUND(MAX(CASE WHEN Indicator_Name = 'Literacy rate, adult female (% of females ages 15 and above)' THEN Value END), 2) AS Female,
    ROUND(MAX(CASE WHEN Indicator_Name = 'Literacy rate, adult male (% of males ages 15 and above)' THEN Value END), 2) AS Male
FROM 
    gender_civ
WHERE 
    Indicator_Name IN (
        'Literacy rate, adult female (% of females ages 15 and above)',
        'Literacy rate, adult male (% of males ages 15 and above)'
    ) 
GROUP BY
    Year
ORDER BY 
    Year;
```
###### Analysis Results
![literacy rates above](https://github.com/MoazWael2/Moaz_portfolio/assets/137816418/01c6a45f-ada2-43c5-8bf9-5d76b8fbc51d)

###### Findings
- Overall Increase in Literacy Rates: Both male and female literacy rates show a significant increase, especially after 2012.
- Gender Gap Narrowing: Initially, there is a noticeable gap between male and female literacy rates. However, this gap has been decreasing over the years.
- Female Literacy Rate Growth: The growth in female literacy rates is more pronounced than that of males.
  
###### Recommendations
- The positive trends suggest that existing educational programs are effective and should be sustained.
-  It would be beneficial to study the underlying factors that have led to the rapid improvement in female literacy rates since 2012 to replicate this success in other areas.
  
##### 4- Women's Employment Distribution Across Sectors in Côte d'Ivoire (2020)
###### SQL Query
The following SQL query examines the distribution of female employment across different economic sectors in Côte d'Ivoire for the year 2020. This analysis provides insight into the economic participation of women and helps to identify sectors where women are more prevalent in the workforce.
```sql
-- This query selects employment data for women in Côte d'Ivoire for the year 2020, 
-- focusing on various sectors to understand the landscape of female employment.

SELECT
    Indicator_Name,
    Year,
    Value
FROM 
    gender_civ
WHERE
    Indicator_Name IN 
    (
        'Employment in agriculture, female (% of female employment) (modeled ILO estimate)',
        'Employment to population ratio, 15+, female (%) (modeled ILO estimate)',
        'Self-employed, female (% of female employment) (modeled ILO estimate)',
        'Vulnerable employment, female (% of female employment) (modeled ILO estimate)',
        'Wage and salaried workers, female (% of female employment) (modeled ILO estimate)',
        'Employment in services, female (% of female employment) (modeled ILO estimate)',
        'Part time employment, female (% of total female employment)'
    )
    AND 
    Year = 2020;
```
###### Analysis Results
![Bussines](https://github.com/MoazWael2/Moaz_portfolio/assets/137816418/5f13aa6d-a13f-45d5-b9d8-79d8d9f119a5)

###### Findings
- The highest percentage of female employment is in the self-employed sector, followed closely by those categorized as vulnerable employment. This could indicate a large number of women are in informal work or run their own small businesses.
- Employment in services also constitutes a significant portion of female employment, which aligns with global trends of women participating in the service industry.
- The lowest percentage of female employment is seen in wage and salaried workers. This could suggest a gap in formal employment opportunities for women or a preference for more flexible or self-managed work environments.
  
###### Recommendations
- Given the high percentage of women in self-employment, policies to support women entrepreneurs could be effective.
- The high rate of women in vulnerable employment warrants further investigation to improve job security and working conditions.
- Efforts should be made to increase women's participation in formal wage and salaried employment through education, training programs, and policy changes that encourage equal hiring practices.
  
##### 5- Women who believe a husband is justified in beating his wife
###### SQL query
-- This SQL query extracts the percentage of women who believe a husband is justified in beating his wife under specific circumstances, offering insight into societal attitudes toward domestic violence.
``` sql
SELECT 
    Indicator_Name,
    Year,
    Value
FROM 
    gender_civ
WHERE 
    Indicator_Name IN (
        'Women who believe a husband is justified in beating his wife when she argues with him (%)',
        'Women who believe a husband is justified in beating his wife when she burns the food (%)',
        'Women who believe a husband is justified in beating his wife when she goes out without telling him (%)',
        'Women who believe a husband is justified in beating his wife when she neglects the children (%)',
        'Women who believe a husband is justified in beating his wife (any of five reasons) (%)',
        'Women who believe a husband is justified in beating his wife when she refuses sex with him (%)'
    );
```
###### Analysis Results
![Womeen who believe](https://github.com/MoazWael2/Moaz_portfolio/assets/137816418/388133d7-3165-4335-aa86-53b337ea239c)

###### Findings
- The Analysis indicates that the most commonly accepted justification for domestic violence is arguing, followed by neglecting the children, and going out without informing the husband.
- Burning food and refusing sex with him are considered the least justifiable reasons for domestic violence among the surveyed women.
###### Recommendations
- Launch campaigns to raise awareness about the negative impacts of domestic violence and promote healthier relationship dynamics.
- Support Services: Increase support services for victims of domestic violence, including hotlines, shelters, and counseling.
- Legal Framework Strengthening: Work towards strengthening the legal framework to protect women against domestic violence and ensure that laws are properly enforced.

##### 6- Women's Rights Progress Comparison: 2010 vs. 2020

###### SQL Query
The following SQL query compares the progress made in terms of legal rights for women in Côte d'Ivoire between the years 2010 and 2020. The indicators chosen represent various domains of legal and social status.
```sql
-- This SQL query is intended to compare the status of women's rights in Côte d'Ivoire in 2010 and 2020.
-- The query outputs whether certain rights were affirmed (Yes) or not (No) in these years.

SELECT 
    Indicator_Name,
    MAX(CASE WHEN Value = 1 AND Year = 2010 THEN 'Yes' ELSE 'No' END) AS Y2010,
    MAX(CASE WHEN Value = 1 AND Year = 2020 THEN 'Yes' ELSE 'No' END) AS Y2020
FROM 
    gender_civ
WHERE 
    Indicator_Name IN (
        'A woman can apply for a passport in the same way as a man (1=yes; 0=no)',
        'A woman can be head of household in the same way as a man (1=yes; 0=no)',
        'A woman can choose where to live in the same way as a man (1=yes; 0=no)',
        'A woman can get a job in the same way as a man (1=yes; 0=no)',
        'A woman can sign a contract in the same way as a man (1=yes; 0=no)',
        'A woman can travel outside her home in the same way as a man (1=yes; 0=no)',
        'A woman can work at night in the same way as a man (1=yes; 0=no)',
        'Men and women have equal ownership rights to immovable property (1=yes; 0=no)'
    )
    AND 
    Year IN (2010, 2020)
GROUP BY 
    Indicator_Name;
```
###### Analysis Results
![Womeen rights](https://github.com/MoazWael2/Moaz_portfolio/assets/137816418/f501fa66-0d95-44ce-9f5b-1e68b6155ffe)

