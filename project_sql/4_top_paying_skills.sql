/*
QUESTION: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Engineer positions.
- Focus on roles with specified salaries, irrespective of location.
Why? It reveals how different skills impact salary levels for Data Engineers
    and helps identify the most financially rewarding skills to develop.
*/

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

/*
Here's the result set I found for top-paying skills as a JSON:

[
  {
    "skills": "assembly",
    "average_salary": "192500"
  },
  {
    "skills": "mongo",
    "average_salary": "182223"
  },
  {
    "skills": "ggplot2",
    "average_salary": "176250"
  },
  {
    "skills": "rust",
    "average_salary": "172819"
  },
  {
    "skills": "clojure",
    "average_salary": "170867"
  },
  {
    "skills": "perl",
    "average_salary": "169000"
  },
  {
    "skills": "neo4j",
    "average_salary": "166559"
  },
  {
    "skills": "solidity",
    "average_salary": "166250"
  },
  {
    "skills": "graphql",
    "average_salary": "162547"
  },
  {
    "skills": "julia",
    "average_salary": "160500"
  },
  {
    "skills": "splunk",
    "average_salary": "160397"
  },
  {
    "skills": "bitbucket",
    "average_salary": "160333"
  },
  {
    "skills": "zoom",
    "average_salary": "159000"
  },
  {
    "skills": "kubernetes",
    "average_salary": "158190"
  },
  {
    "skills": "numpy",
    "average_salary": "157592"
  },
  {
    "skills": "mxnet",
    "average_salary": "157500"
  },
  {
    "skills": "fastapi",
    "average_salary": "157500"
  },
  {
    "skills": "redis",
    "average_salary": "157000"
  },
  {
    "skills": "trello",
    "average_salary": "155000"
  },
  {
    "skills": "jquery",
    "average_salary": "151667"
  },
  {
    "skills": "express",
    "average_salary": "151636"
  },
  {
    "skills": "cassandra",
    "average_salary": "151282"
  },
  {
    "skills": "unify",
    "average_salary": "151000"
  },
  {
    "skills": "kafka",
    "average_salary": "150549"
  },
  {
    "skills": "vmware",
    "average_salary": "150000"
  }
]
*/

