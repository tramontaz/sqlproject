USE sqltask;

(SELECT 
    project_name, 
    projectcost 
FROM 
    projects, 
    (SELECT 
        project_id, 
        sum(costfield) AS projectcost 
    FROM 
        teamsInTheProject, 
        (SELECT 
            team_id, 
            sum(developer_salary) AS costfield 
        FROM 
            developers, 
            devInTeam 
        WHERE developers.developer_id = devInTeam.developer_id 
        GROUP BY team_id) AS costOfTeams 
    WHERE costOfTeams.team_id = teamsInTheProject.team_id 
    GROUP BY project_id) AS projectcosttable 
WHERE projects.project_id = projectcosttable.project_id) 
ORDER BY projectcost DESC LIMIT 1;
