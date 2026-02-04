# Introduction
🤿 Dive into the Data job market!
Focusing on **Data Engineer** roles, this project explores 💷 **top-paying jobs**, 🤹 **in-demand skills** and 🧑‍💻 where ***high-demand*** meets ***high salary*** in Data Engineering.

🕵️ **SQL Queries?** Check them out here --> [project_sql foler](/project_sql/)

# Background
🧭 Driven by a quest to navigate the Data Engineer job market more effectively, this project was born from a necessity to pinpoint top-paying and in-demand skills, streamlining others' work to find optimal jobs.

The data originates from a **Youtube** [SQL Course by Luke Barousse](https://www.lukebarousse.com/sql). This data includes details for job titles, salaries, locations and their required skills.

The questions I wanted to answer through my **SQL queries** were:

1. What are the top-paying Data Engineer jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in-demand for Data Engineers?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn for a Data Engineer looking to maximise their market value?

# Tools I've Used

In this project, I've utilised a variety of tools to conduct my analysis, such as:

* **SQL** (Structured Query Language): Enabled me to interact with the database, to extract insights and to answer my questions through queries.

* **PostgreSQL**: As the database management system, PostgreSQL allowed me to store, query, and manipulate the postings data.

* **Visual Studio Code**: This open-source administration and development platform has helped me manage the database and execute my SQL queries.

# The Analysis

Each query for this project was aimed at investigating specific aspects of the Data Engineer job market. Here's how I've approached each question:

### 1. Top Paying Data Engineer Jobs
In order to identify the highest-earning roles, I filtered Data Engineer positions by the average annual salary and location, focusing on remote roles. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Engineer' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10;
```

### 2. Skills for Top Paying Jobs
In order to understand which skills are required for top-earning jobs, I've joined the **job postings** with the **skills data**, providing insights into what employers value for highly-compensated roles.

```sql
WITH top_paying_jobs AS (
SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Engineer' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10
)

SELECT
    top_paying_jobs.*,
    skills_dim.skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
### 3. In-Demand Skills for Data Engineers
This query helped to identify the skills that are most frequently requested in job postings, with high-demand areas of key focus.

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY demand_count DESC
LIMIT 5;
```
### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills garner higher earnings.

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    average_salary DESC
LIMIT 25;
```

### 5. Most Optimal Skills to Learn
This combined insights from demand and salary data, aiming to pinpoint skills that are both high in demand and attracting higher salaries. This offers a strategic focus for skill development.

```sql
WITH skills_demand AS (
  SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
  FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
  WHERE
    job_postings_fact.job_title_short = 'Data Engineer'
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = TRUE
  GROUP BY
    skills_dim.skill_id
),

average_salary AS (
  SELECT
    skills_job_dim.skill_id,
    AVG(job_postings_fact.salary_year_avg) AS avg_salary
  FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  WHERE
    job_postings_fact.job_title_short = 'Data Engineer'
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_work_from_home = TRUE
  GROUP BY
    skills_job_dim.skill_id
)

SELECT
    skills_demand.skills,
    skills_demand.demand_count,
    ROUND(average_salary.avg_salary, 2) AS avg_salary
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 25;
```
*(It's worth nothing that this was a pig of a query to get right at this early stage!)*

Each of these queries not only served to answer a specific question but also to improve my understanding of **SQL** and **database analysis**. Through this project, I've learned to leverage SQL's powerful **data manipulation** capabilities to derive meaningful insights from **complex datasets**.

# What I've Learned
Throughout this project, I've developed several key **SQL** techniques and skills:

**• Complex Query Construction**: Learning to build advanced SQL queries that combine multiple tables and employ functions like `WITH` clauses for temporary tables.

**• Data Aggregation**: Utitlising `GROUP BY` and aggregate functions like `COUNT()` and `AVG()` to summarise data effectively.

**• Analytical Thinking**: Developing the ability to translate real-world questions into actionable SQL queries that gave insightful answers.

## Insights
From the analysis, several general insights emerged:

**1. Top-Paying Data Engineer Jobs:** The highest-earning jobs for Data Engineers that allow remote work offer a wide range of salaries, the highest at $325,000!

**2. Skills for Top-Earning Jobs:** High-earning Data Engineer jobs require advanced proficiency in **Python**, suggesting it's a critical skill for earning a top salary.

**3. Most In-Demand Skills:** By comparison, **SQL** is the most desired skill in the Data Engineer job market, which make this and **Python** essential for job seekers.

**4. Skills with Higher Salaries:** Specialised skills such as **Assembly** and **MongoDB** correlate with higher salaries, which indicate a premium on niche abilities.

**5. Optimal Skills for Job Market Value:** SQL still leads demand and offers for a higher average salary, positioning it as one of the most optimal skills for Data Engineers to learn and, therefore, maximise their market value.

# Conclusion
I have really enjoyed working on this project. It's proven to have enhanced my skills with **SQL** and also allowed me to use both **PostgreSQL** and **Visual Studio Code**, which are both new softwares for me (I've previously only used **MySQL**).
The findings from the analysis serve as a guide to prioritising skill development and job search efforts. Aspiring Data Engineers can position themselves better in a rather competitive job market through focusing on high-demand, high-earning skills.
This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of Data Engineering.