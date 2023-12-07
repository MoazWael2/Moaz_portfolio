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


