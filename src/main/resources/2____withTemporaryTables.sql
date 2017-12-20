USE sqltask;
CREATE TEMPORARY TABLE IF NOT EXISTS `cost_of_teams` (
team_id int not null,
cost decimal(10,2) default 0
);

INSERT INTO `cost_of_teams` (team_id, cost)
SELECT team_id, sum(developer_salary) FROM developers, developersInTheTeam 
WHERE developers.developer_id = developersInTheTeam.developer_id GROUP BY team_id;

#AND NOT EXISTS (SELECT team_id FROM cost_of_teams)

CREATE TEMPORARY TABLE IF NOT EXISTS `cost_of_project` (
project_id int not null,
cost decimal(15,2) default 0
);

INSERT INTO `cost_of_project` (project_id, cost)
SELECT project_id, sum(cost_of_teams.cost) FROM cost_of_teams, teamsInTheProject 
WHERE cost_of_teams.team_id = teamsInTheProject.team_id GROUP BY project_id;

SELECT project_name FROM projects WHERE project_id = 
(SELECT project_id FROM teamsInTheProject INNER JOIN cost_of_project using(project_id) ORDER BY cost DESC LIMIT 1);

