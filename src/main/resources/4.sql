USE `sqltask`;

ALTER TABLE `projects` ADD COLUMN `cost` DECIMAL(15,2) NOT NULL DEFAULT 0 AFTER `project_name`;

UPDATE projects SET cost =
(
SELECT cost FROM
(
SELECT project_id, project_name, projectcost cost FROM projects JOIN (
SELECT project_id, sum(costfield) AS projectcost 
FROM teamsInTheProject, (SELECT team_id, sum(developer_salary)AS costfield FROM developers, devInTeam 
WHERE developers.developer_id = devInTeam.developer_id GROUP BY team_id) AS costOfTeams 
WHERE costOfTeams.team_id = teamsInTheProject.team_id GROUP BY project_id) AS projectCostTable USING(project_id)
) AS jointable
WHERE projects.project_id = jointable.project_id);


SELECT * FROM projects;
