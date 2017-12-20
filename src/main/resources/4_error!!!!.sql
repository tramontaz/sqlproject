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
cost decimal(15,2) not null default 0
);

INSERT INTO `cost_of_project` (project_id, cost)
SELECT project_id, sum(cost_of_teams.cost) FROM cost_of_teams, teamsInTheProject 
WHERE cost_of_teams.team_id = teamsInTheProject.team_id GROUP BY project_id;

CREATE TEMPORARY TABLE IF NOT EXISTS `temp_projects` (
id int not null,
name varchar(45) not null,
cost decimal(15,2)  not null default 0
);

INSERT INTO `temp_projects` (id, name, cost)
SELECT * FROM `sqltask`.`projects` LEFT JOIN cost_of_project USING(project_id) WHERE cost_of_project.cost is not null;

ALTER TABLE `sqltask`.`projects` ADD COLUMN `cost` DECIMAL(15,2) NOT NULL DEFAULT 0 AFTER `project_name`;

UPDATE `sqltask`.`projects` SET cost = 
(SELECT `cost` FROM `temp_projects` WHERE temp_projects.id = projects.project_id);

SELECT * FROM projects;
