```SQL
-- Gender Equality Data Analysis for Côte d'Ivoire

-- This SQL script is part of a data analysis project that explores various gender equality indicators in Côte d'Ivoire.
-- The purpose of the script is to extract and manipulate data for further analysis and visualization.

-- Use the 'czechia_gender' database
USE czechia_gender;

-- Retrieve unique indicators from the 'gender_civ' table
SELECT DISTINCT Indicator_Name
FROM gender_civ;

-- Insert a new record for the literacy rate of adult males in 2016
INSERT INTO czechia_gender.gender_civ (
    Country_Name,
    Country_Code,
    Year,
    Indicator_Name,
    Indicator_Code,
    Value
)
VALUES (
    'Cote d''Ivoire', 
    'CIV', 
    2016, 
    'Literacy rate adult male (% of males ages 15 and above)',
    'SE.ADT.LITR.FE.ZS', 
    45
);

-- Update the literacy rate value for adult males in 2016
UPDATE czechia_gender.gender_civ
SET Value = 59
WHERE Indicator_Name = 'Literacy rate adult male (% of males ages 15 and above)'
  AND Year = 2016;

-- Insert new data for part-time female employment in 2020
INSERT INTO czechia_gender.gender_civ (
    Country_Name,
    Country_Code,
    Year,
    Indicator_Name,
    Indicator_Code,
    Value
)
VALUES (
    'Cote d''Ivoire', 
    'CIV', 
    2020, 
    'Part time employment, female (% of total female employment)',
    'SL.TLF.PART.FE.ZS',
    38
);

-- The remaining queries are designed to aggregate and organize data related to education, labor force participation, 
-- women's rights, and perceptions of domestic violence, which will inform a comprehensive gender equality analysis.

 
-- Gendered Education Completion Rates for Adults Over 25 (1998-2016)
-- This section of the analysis focuses on the educational attainment of the adult population over 25 years old in Côte d'Ivoire, differentiated by gender. The SQL query calculates the cumulative education completion rates for both females and males for the years 1998, 2014, and 2016.

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

-- Analysis of Evolving Gender Gaps in Child Education (1977-2022)
-- The following SQL query aims to analyze the evolving gender gaps in child education by examining the number of children out of school at the primary level. The data spans from 1977 to 2022 and is separated by gender to provide insights into disparities and trends over time.
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

-- (Literacy Rate Analysis) Evolution of Literacy Rate Among Individuals Over 15 Years Old
-- This section of the analysis examines the changes in literacy rates among the population aged over 15 in Côte d'Ivoire, with a breakdown by gender. The purpose of the SQL query is to extract the literacy rates for adult males and females to assess educational progress and identify potential gaps in literacy.
-- This query is designed to determine the literacy rates for adults over 15 years of age, 
-- broken down by gender, providing a comprehensive overview of the literacy landscape over the years.

  SELECT 
      'Literacy rate Above 15%' AS Indicator,
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
      
-- Women's Employment Distribution Across Sectors in Côte d'Ivoire (2020)

-- The following SQL query examines the distribution of female employment across different economic sectors in Côte d'Ivoire for the year 2020. This analysis provides insight into the economic participation of women and helps to identify sectors where women are more prevalent in the workforce.
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

-- Labor force participation rate Above15
	select 
         'Labor force participation rate Above15' as Indicator,
          year,
         ROUND(MAX(CASE WHEN Indicator_Name = 'Labor force participation rate, female (% of female population ages 15+) (modeled ILO estimate)' THEN Value END),2) AS Female,
         ROUND(MAX(CASE WHEN Indicator_Name = 'Labor force participation rate, male (% of male population ages 15+) (modeled ILO estimate)' THEN Value END),2) AS Male
     FROM 
         gender_civ
     WHERE 
      Indicator_Name IN (
      'Labor force participation rate, male (% of male population ages 15+) (modeled ILO estimate)',
      'Labor force participation rate, female (% of female population ages 15+) (modeled ILO estimate)'
       ) 
     GROUP BY
	   year
     ORDER BY 
	   Year;
 
 -- This SQL query is designed to pull comprehensive data on vital women's health and employment indicators over recent years.

  SELECT *
  FROM gender_civ
  WHERE Indicator_Name IN (
      'Lifetime risk of maternal death (%)',
      'Pregnant women receiving prenatal care (%)',
      'Life expectancy at birth, female (years)',
      'Labor force participation rate, female (% of female population ages 15+) (modeled ILO estimate)'
  )
  AND
    Year BETWEEN 2015 AND 2022;

-- This SQL query extracts the percentage of women who believe a husband is justified in beating his wife under specific circumstances, offering insight into societal attitudes toward domestic violence.

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
 
-- Women's Rights Progress Comparison: 2010 vs. 2020
-- The following SQL query compares the progress made in terms of legal rights for women in Côte d'Ivoire between the years 2010 and 2020. The indicators chosen represent various domains of legal and social status.
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
