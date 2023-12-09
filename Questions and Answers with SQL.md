# Women Empowerment Analysis in Côte d’Ivoire

**Name**: Moaz Wael Hanafy <br />
**Email**: moazwael1997@gmail.com <br />
**LinkedIn**: [View Profile](https://www.linkedin.com/in/moaz-wael-14212323a) 

## Questions and Answers with SQL

#### 1- How is the educational attainment of the adult population over 25 years old in Côte d'Ivoire analyzed by gender for the years 1998, 2014, and 2016?
```sql
  SELECT 
      'Educational_attainment_Above25%of_gender' AS Indicator,
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
Results:

![1](https://github.com/MoazWael2/Women-Empowerment-in-C-te-d-Ivoire_analysis/assets/137816418/a7c87e10-e57a-4483-bf28-7407d3d6ea14)


#### 2- Is there been evidence of government or societal efforts effectively reducing this gap and the overall number of children not in school and What has been the trend in the gender gap among children out of school in Côte d'Ivoire over the years?
```SQL
  SELECT 
      'Child_out_School' AS Indicator,
      Year,
      ROUND(MAX(CASE WHEN Indicator_Name = 'Children out of school, primary, female' THEN Value END), 2) AS Female,
      ROUND(MAX(CASE WHEN Indicator_Name = 'Children out of school, primary, male' THEN Value END), 2) AS Male,
      ROUND(MAX(CASE WHEN Indicator_Name = 'Children out of school, primary, male' THEN Value END), 2) + 
      ROUND(MAX(CASE WHEN Indicator_Name = 'Children out of school, primary, female' THEN Value END), 2) AS Total
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
Results:

![2](https://github.com/MoazWael2/Women-Empowerment-in-C-te-d-Ivoire_analysis/assets/137816418/a2050bd3-5155-49f7-b4e0-5388c2806d2b)


#### 3- How has the literacy rate among individuals over the age of 15 in Côte d'Ivoire evolved over the years, and can we observe distinct trends or disparities between genders?
``` SQL
  SELECT 
      'Literacy rate Above 15(% of each Gender)' AS Indicator,
      Year,
      ROUND(MAX(CASE WHEN Indicator_Name = 'Literacy rate, adult female (% of females ages 15 and above)' THEN Value END), 2) AS Female,
      ROUND(MAX(CASE WHEN Indicator_Name = 'Literacy rate, adult male (% of males ages 15 and above)' THEN Value END), 2) AS Male,
      ROUND(MAX(CASE WHEN Indicator_Name = 'Literacy rate, adult female (% of females ages 15 and above)' THEN Value END)
       +
      MAX(CASE WHEN Indicator_Name = 'Literacy rate, adult male (% of males ages 15 and above)' THEN Value END), 2) AS Total
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
Result:

![3](https://github.com/MoazWael2/Women-Empowerment-in-C-te-d-Ivoire_analysis/assets/137816418/6d0aac7b-5589-4cee-b95a-1827b73cddd9)

#### 4- In the context of Côte d'Ivoire's economy for the year 2020, how are women distributed across various employment sectors, and which sectors are most and least populated by female workers?
``` SQL
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
Result:

![4](https://github.com/MoazWael2/Women-Empowerment-in-C-te-d-Ivoire_analysis/assets/137816418/881191ca-1643-4035-9a11-b1ecfe93fd4c)

#### 5- Has the Côte d'Ivoire government been successful in balancing the labor force participation between genders over the years?
```SQL
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
 Result:

![5](https://github.com/MoazWael2/Women-Empowerment-in-C-te-d-Ivoire_analysis/assets/137816418/605a3b60-5e24-47db-ae11-00b2b192dc41)

#### 6- Has Côte d'Ivoire made significant strides in enhancing women's health between 2015 and 2022?
```SQL
  SELECT
      Indicator_Name,
      Year,
      ROUND(Value,2) AS Value
  FROM gender_civ
  WHERE Indicator_Name IN (
      'Lifetime risk of maternal death (%)',
      'Pregnant women receiving prenatal care (%)'
  )
  AND
    Year BETWEEN 2015 AND 2022;
```
Result:

![6](https://github.com/MoazWael2/Women-Empowerment-in-C-te-d-Ivoire_analysis/assets/137816418/c2b46514-3841-4a36-955b-20c92d34b8aa)


#### 6- What is the prevalent attitude among women in Côte d'Ivoire regarding domestic violence under specific circumstances?
```SQL
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
Result:

![7](https://github.com/MoazWael2/Women-Empowerment-in-C-te-d-Ivoire_analysis/assets/137816418/a97b0ea6-2980-4892-91f4-7ae9c07329b8)

#### 7- Has there been significant progress in women's legal rights in Côte d'Ivoire from 2010 to 2020, particularly in areas such as passport application, head of household status, employment, and property rights?
```SQL
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
Result:

![8](https://github.com/MoazWael2/Women-Empowerment-in-C-te-d-Ivoire_analysis/assets/137816418/24cff567-3e05-48b8-93d3-3ac4f38461a8)


**Thank you for exploring "Women Empowerment Analysis" in Côte d'Ivoire. We hope this analysis provides valuable insights and fosters discussions that contribute to ongoing efforts in promoting gender equality. For any questions, suggestions, or collaborations, feel free to reach out or contribute to this project. Your feedback and engagement are highly appreciated.**
