SET sql_mode = '';

SELECT customer_id, company_id, min(profit) AS minprofit FROM customersOfCompanies INNER JOIN 
(SELECT customer_id, sum(cost) AS profit FROM (SELECT * FROM projects INNER JOIN projectsFromTheCustmer USING(project_id)) AS temporarytable GROUP BY customer_id) AS mytemptable
USING(customer_id) GROUP BY company_id;
