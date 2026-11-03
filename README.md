# NYSC_Registration_Data_Analysis

## Project Overview

This project uses SQL to explore NYSC registration records and summarize registrants by age, origin state, preferred service state, institution, course of study, and graduating honours.

## Data Cleaning & Preparation

In the initial data preparation phase, we performed the following tasks:
1. Data loading and inspection.
2. Handling missing values and duplicates
3. Data cleaning and formatting

### Step-by-step: import the CSV into MySQL Workbench

- Open MySQL Workbench and connect to your MySQL server.
- Create a schema named nysc_project: right-click in the SCHEMAS panel → Create Schema → type nysc_project → Apply.
- Right-click nysc_project → Table Data Import Wizard.
- Browse to nysc_registration_data.csv and select it.
- Choose nysc_project as the destination schema and enter nysc_registration_data as the table name.
- Check that the first row is treated as column headers and the comma delimiter is correct. Inspect the preview before proceeding.
- Click Next/Import/Finish and wait for the wizard to complete.
- Open a SQL tab and run: USE nysc_project; SELECT COUNT(*) FROM nysc_registration_data; The count should be 10000.
- Run DESCRIBE nysc_registration_data; to verify the column names and data types.

   
## Project Objectives/EDA

- Retrieve selected registrant details and filter records using conditions.
- Identify distributions and counts by state, institution, course, and honours.
- Use subqueries to answer comparative and ranking questions.
- Summarize actionable findings for NYSC planning and reporting.

  
## Tools and Technologies

- **Microsoft Excel:** Supporting spreadsheet analysis and data handling.
- **MySQL:** Running queries and extracting relevant data and as needed.

## SQL Techniques Demonstrated

| SQL COMMANDS | DESCRIPTION |
|---|---|
| SELECT / WHERE | Retrieve fields and filter rows by conditions |
| LIKE / DISTINCT | Match email patterns and list unique values |
| ORDER BY / LIMIT Sort | Records and retrieve top results |
| COUNT / AVG / GROUP BY | Summarize totals, averages, and category counts |
| HAVING | Filter grouped results after aggregation |
| Subqueries / IN | Compare records to calculated results or sets |
| RANK() OVER | Rank records within each institution |

## Conclusion

### Key Findings

- The dataset contains 10,000 records with an average age of 24.96 years.
- Biology is the most common course (711).
- University of Calabar has the highest institution count (1,049).
- Cross River leads institution-state representation (1,049).
- Honours categories are broadly balanced, each representing about 19%–21%.

### Recommendations

-  Use dashboards to monitor age, honors, course, and state distributions.
-  Review preferred-state patterns to understand service location preferences.
-  Validate category labels and standardize state/institution names before reporting.
-  Add a verified Gender field only if gender-based analysis is required.
-  Refresh the analysis when new registration records become available.
  
## Author

**DAUdofia**

**Aspiring Data Analyst | Business Intelligence | Data Visualization**

Passionate about turning data into insights that support smarter business decisions.
