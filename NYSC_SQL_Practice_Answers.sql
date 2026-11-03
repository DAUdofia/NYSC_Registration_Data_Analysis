-- NYSC Registration Dataset — SQL Practice Exercises
-- Source: NYSC_SQL_Practice_Exercises.pdf and nysc_registration_data.csv
-- Assumed MySQL table name: nysc_registration_data
-- Import the CSV into MySQL Workbench and use this table name, or replace it below.
-- Column names with spaces are enclosed in backticks.


-- SECTION 1 — Basic SELECT & Filtering

-- 1. Retrieve all columns from the table.
SELECT *
FROM `nysc_registration_data`;


-- 2. Show only the Fullname, Age, and Gmail of all registrants.
SELECT `Fullname`, `Age`, `Gmail`
FROM `nysc_registration_data`;


-- 3. List all registrants whose age is greater than 25.
SELECT *
FROM `nysc_registration_data`
WHERE `Age` > 25;


-- 4. Display all records where the origin state is 'Lagos'.
SELECT *
FROM `nysc_registration_data`
WHERE `Origin State` = 'Lagos';


-- 5. Find all registrants who graduated with 'First Class'.
SELECT *
FROM `nysc_registration_data`
WHERE `Graduating Honors` = 'First Class';


-- 6. Retrieve the names of registrants whose preferred state is 'Abuja' and origin state is 'Kano'.
SELECT `Fullname`
FROM `nysc_registration_data`
WHERE `Preferred State` = 'Abuja'
  AND `Origin State` = 'Kano';


-- 7. Show all registrants whose email address ends with '@gmail.com'.
SELECT *
FROM `nysc_registration_data`
WHERE `Gmail` LIKE '%@gmail.com';


-- SECTION 2 — Sorting & Distinct

-- 1. List all unique origin states in the dataset.
SELECT DISTINCT `Origin State`
FROM `nysc_registration_data`
ORDER BY `Origin State`;


-- 2. Display all registrants ordered by Age in descending order.
SELECT *
FROM `nysc_registration_data`
ORDER BY `Age` DESC;


-- 3. Show the top 5 oldest registrants.
SELECT *
FROM `nysc_registration_data`
ORDER BY `Age` DESC, `Fullname` ASC
LIMIT 5;


-- 4. Find all unique institutions in the dataset.
SELECT DISTINCT `Institution`
FROM `nysc_registration_data`
ORDER BY `Institution`;


-- SECTION 3 — Aggregation & Grouping

-- 1. Count the total number of registrants.
SELECT COUNT(*) AS `Total Registrants`
FROM `nysc_registration_data`;


-- 2. Find the average age of all registrants.
SELECT ROUND(AVG(`Age`), 0) AS `Average Age`
FROM `nysc_registration_data`;


-- 3. Count how many registrants come from each origin state.
SELECT `Origin State`, COUNT(*) AS `Total Registrants`
FROM `nysc_registration_data`
GROUP BY `Origin State`
ORDER BY `Total Registrants` DESC;


-- 4. Show the number of registrants from each preferred state, ordered from most to least preferred.
SELECT `Preferred State`, COUNT(*) AS `Registrant Count`
FROM `nysc_registration_data`
GROUP BY `Preferred State`
ORDER BY `Registrant Count` DESC, `Preferred State` ASC;


-- 5. Display the number of graduates by each graduating honors category.
SELECT `Graduating Honors`, FORMAT(COUNT(*), 'N2') AS `Graduate Count`
FROM `nysc_registration_data`
GROUP BY `Graduating Honors`
ORDER BY `Graduate Count` DESC;


-- 6. Find the average age of registrants for each institution.
SELECT `Institution`, ROUND(AVG(`Age`), 0) AS `Average Age`
FROM `nysc_registration_data`
GROUP BY `Institution`
ORDER BY `Average Age` DESC;


-- SECTION 4 — Conditional & Filtering Aggregates

-- 1. Find all institutions that have more than 100 registrants.
SELECT `Institution`, COUNT(*) AS `Registrant Count`
FROM `nysc_registration_data`
GROUP BY `Institution`
HAVING COUNT(*) > 100
ORDER BY `Registrant Count` DESC;


-- 2. Count how many registrants from Rivers State prefer to serve in Lagos.
SELECT COUNT(*) AS `Rivers-to-Lagos Registrants`
FROM `nysc_registration_data`
WHERE `Origin State` = 'Rivers'
  AND `Preferred State` = 'Lagos';


-- 3. Calculate the average age of registrants who graduated with Second Class Upper.
SELECT ROUND(AVG(`Age`), 2) AS `Average Age`
FROM `nysc_registration_data`
WHERE `Graduating Honors` = 'Second Class Upper';


-- 4. List all courses that have more than 50 graduates.
SELECT `Course Study`, COUNT(*) AS `Graduate Count`
FROM `nysc_registration_data`
GROUP BY `Course Study`
HAVING COUNT(*) > 50
ORDER BY `Graduate Count` DESC;


-- 5. Find the youngest and oldest registrant.
SELECT *
FROM `nysc_registration_data`
WHERE `Age` = (SELECT MIN(`Age`) FROM `nysc_registration_data`)
   OR `Age` = (SELECT MAX(`Age`) FROM `nysc_registration_data`)
ORDER BY `Age`, `Fullname`;


-- SECTION 5 — Subqueries & Analytical Thinking

-- 1. Find registrants whose age is above the overall average age.
SELECT *
FROM `nysc_registration_data`
WHERE `Age` > (SELECT AVG(`Age`) FROM `nysc_registration_data`)
ORDER BY `Age` DESC;


-- 2. List all registrants who attended an institution located in the same state as their origin state.
SELECT *
FROM `nysc_registration_data`
WHERE `Origin State` = `Institution State`;


-- 3. Identify the most common course of study among registrants.
SELECT `Course Study`, COUNT(*) AS `Registrant Count`
FROM `nysc_registration_data`
GROUP BY `Course Study`
ORDER BY `Registrant Count` DESC
LIMIT 1;


-- 4. Find the preferred state of the youngest registrant.
SELECT `Fullname`, `Age`, `Preferred State`
FROM `nysc_registration_data`
WHERE `Age` = (SELECT MIN(`Age`) FROM `nysc_registration_data`)
ORDER BY `Fullname`;


-- 5. Show the institution(s) that produced the highest number of First Class graduates.
WITH first_class_counts AS (
  SELECT `Institution`, COUNT(*) AS `First Class Count`
  FROM `nysc_registration_data`
  WHERE `Graduating Honors` = 'First Class'
  GROUP BY `Institution`
)
SELECT `Institution`, `First Class Count`
FROM first_class_counts
WHERE `First Class Count` = (
  SELECT MAX(`First Class Count`) FROM first_class_counts
);


-- 6. List all origin states whose registrants prefer to serve outside their home state.
SELECT DISTINCT `Origin State`
FROM `nysc_registration_data`
WHERE `Preferred State` <> `Origin State`
ORDER BY `Origin State`;


-- 7. Determine which institution state contributes the most registrants.
SELECT `Institution State`, COUNT(*) AS `Registrant Count`
FROM `nysc_registration_data`
GROUP BY `Institution State`
ORDER BY `Registrant Count` DESC
LIMIT 1;


-- 8. Find all registrants whose course study matches any course studied at University of Lagos (using a subquery).
SELECT *
FROM `nysc_registration_data`
WHERE `Course Study` IN (
  SELECT DISTINCT `Course Study`
  FROM `nysc_registration_data`
  WHERE `Institution` = 'University of Lagos'
);


-- BONUS CHALLENGES

-- 1. Create a query to find the percentage distribution of each graduating honor category.
SELECT `Graduating Honors`,
       COUNT(*) AS `Graduate Count`,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM `nysc_registration_data`), 2) AS `Percentage`
FROM `nysc_registration_data`
GROUP BY `Graduating Honors`
ORDER BY `Percentage` DESC;


-- 2. Find the top 3 most common institutions.
SELECT `Institution`, COUNT(*) AS `Registrant Count`
FROM `nysc_registration_data`
GROUP BY `Institution`
ORDER BY `Registrant Count` DESC
LIMIT 3;


-- 3. Show for each origin state: total registrants, average age, and most common preferred state.
WITH preferred_counts AS (
  SELECT `Origin State`, `Preferred State`, COUNT(*) AS preference_count
  FROM `nysc_registration_data`
  GROUP BY `Origin State`, `Preferred State`
), ranked_preferences AS (
  SELECT `Origin State`, `Preferred State`, preference_count,
         ROW_NUMBER() OVER (
           PARTITION BY `Origin State`
           ORDER BY preference_count DESC, `Preferred State` ASC
         ) AS rn
  FROM preferred_counts
), origin_summary AS (
  SELECT `Origin State`, COUNT(*) AS `Total Registrants`,
         ROUND(AVG(`Age`), 2) AS `Average Age`
  FROM `nysc_registration_data`
  GROUP BY `Origin State`
)
SELECT s.`Origin State`, s.`Total Registrants`, s.`Average Age`,
       r.`Preferred State` AS `Most Common Preferred State`
FROM origin_summary s
LEFT JOIN ranked_preferences r
  ON s.`Origin State` = r.`Origin State` AND r.rn = 1
ORDER BY s.`Origin State`;


-- 4. Write a query that finds the difference between the average ages of male and female registrants (if a gender column existed — describe how you’d modify the dataset).
-- The supplied dataset has no Gender column. Add/populate it from a verified source first:
ALTER TABLE `nysc_registration_data` ADD COLUMN `Gender` VARCHAR(20) NULL;

-- After the Gender column is populated accurately:
SELECT
  ROUND(AVG(CASE WHEN `Gender` = 'Male' THEN `Age` END), 2) AS `Average Male Age`,
  ROUND(AVG(CASE WHEN `Gender` = 'Female' THEN `Age` END), 2) AS `Average Female Age`,
  ROUND(AVG(CASE WHEN `Gender` = 'Male' THEN `Age` END)
      - AVG(CASE WHEN `Gender` = 'Female' THEN `Age` END), 2) AS `Male Minus Female Average Age`
FROM `nysc_registration_data`;


-- 5. Using window functions (if supported), rank registrants by age within each institution.
SELECT `Institution`, `Fullname`, `Age`,
       RANK() OVER (
         PARTITION BY `Institution`
         ORDER BY `Age` DESC
       ) AS `Age Rank Within Institution`
FROM `nysc_registration_data`
ORDER BY `Institution`, `Age Rank Within Institution`, `Fullname`;
