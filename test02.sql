SELECT DM."Object Type", DM."Is _users.id/groups.id", DM."Friendly Name", DM."Is User/Group", DM."Site", DM."site_id", DM."Base Authorization",
DM."Object Name", DM."Project", DM."Workbook", DM."View", DM.capability_id, DM."Capability", RC.user_name, RC."Is SysAdmin", RC."Is SiteAdmin"
FROM (
    SELECT X.*, C.display_name AS "Capability"
    FROM (
        SELECT N.authorizable_type AS "Object Type", N.grantee_id AS "Is _users.id/groups.id", N.grantee_type AS "Is User/Group", N.capability_id, S.name AS "Site", S.id AS "site_id",
            CASE
                WHEN N.permission = 1 THEN 'Grant'
                WHEN N.permission = 2 THEN 'Deny'
                WHEN N.permission = 3 THEN 'Grant'
                WHEN N.permission = 4 THEN 'Deny'
                ELSE NULL
            END AS "Base Authorization",
         U.friendly_name AS "Friendly Name", P.name as "Object Name", P.name as "Project", NULL as "Workbook", NULL as "View" FROM next_gen_permissions N
         LEFT JOIN _users U ON N.grantee_id = U.id
         LEFT JOIN sites S ON U.site_id = S.id
         LEFT JOIN projects P ON N.authorizable_id = P.id WHERE N.grantee_type = 'User' AND N.authorizable_type = 'Project' AND P.name is not NULL
         UNION
         SELECT N.authorizable_type AS "Object Type", N.grantee_id AS "Is _users.id/groups.id", N.grantee_type AS "Is User/Group", N.capability_id, S.name AS "Site", S.id AS "site_id",
             CASE
                 WHEN N.permission = 1 THEN 'Grant'
                 WHEN N.permission = 2 THEN 'Deny'
                 WHEN N.permission = 3 THEN 'Grant'
                 WHEN N.permission = 4 THEN 'Deny'
                 ELSE NULL
             END AS "Base Authorization",
         G.name as "Friendly Name", P.name as "Object Name", P.name as "Project", NULL as "Workbook", NULL as "View"
         FROM next_gen_permissions N
         LEFT JOIN groups G ON N.grantee_id = G.id
         LEFT JOIN sites S ON G.site_id = S.id
         LEFT JOIN projects P ON N.authorizable_id = P.id WHERE N.grantee_type = 'Group' AND N.authorizable_type = 'Project' AND P.name is not NULL
         UNION
         SELECT N.authorizable_type AS "Object Type", N.grantee_id AS "Is _users.id/groups.id", N.grantee_type AS "Is User/Group", N.capability_id, S.name AS "Site", S.id AS "site_id",
             CASE
                 WHEN N.permission = 1 THEN 'Grant'
                 WHEN N.permission = 2 THEN 'Deny'
                 WHEN N.permission = 3 THEN 'Grant'
                 WHEN N.permission = 4 THEN 'Deny'
                 ELSE NULL
             END AS "Base Authorization",
         G.name as "Friendly Name", W.name as "Object Name", P.name as "Project", W.name as "Workbook", NULL as "View"
         FROM next_gen_permissions N
         LEFT JOIN groups G ON N.grantee_id = G.id
         LEFT JOIN sites S ON G.site_id = S.id
         LEFT JOIN workbooks W ON N.authorizable_id = W.id
         LEFT JOIN projects P ON W.project_id = P.id WHERE N.grantee_type = 'Group' AND N.authorizable_type = 'Workbook' AND P.name is not NULL
         UNION
         SELECT N.authorizable_type AS "Object Type", N.grantee_id AS "Is _users.id/groups.id", N.grantee_type AS "Is User/Group", N.capability_id, S.name AS "Site", S.id AS "site_id",
             CASE
                 WHEN N.permission = 1 THEN 'Grant'
                 WHEN N.permission = 2 THEN 'Deny'
                 WHEN N.permission = 3 THEN 'Grant'
                 WHEN N.permission = 4 THEN 'Deny'
                 ELSE NULL
             END AS "Base Authorization",
         U.friendly_name as "Friendly Name", W.name as "Object Name", P.name as "Project", W.name as "Workbook", NULL as "View"
         FROM next_gen_permissions N
         LEFT JOIN _users U ON N.grantee_id = U.id
         LEFT JOIN sites S ON U.site_id = S.id
         LEFT JOIN workbooks W ON N.authorizable_id = W.id
         LEFT JOIN projects P ON W.project_id = P.id WHERE N.grantee_type = 'User' AND N.authorizable_type = 'Workbook' AND P.name is not NULL
         UNION
         SELECT N.authorizable_type AS "Object Type", N.grantee_id AS "Is _users.id/groups.id", N.grantee_type AS "Is User/Group", N.capability_id, S.name AS "Site", S.id AS "site_id",
             CASE
                 WHEN N.permission = 1 THEN 'Grant'
                 WHEN N.permission = 2 THEN 'Deny'
                 WHEN N.permission = 3 THEN 'Grant'
                 WHEN N.permission = 4 THEN 'Deny'
                 ELSE NULL
             END AS "Base Authorization",
         G.name as "Friendly Name", V.name as "Object Name", P.name as "Project", W.name as "Workbook", V.name as "View"
         FROM next_gen_permissions N
         LEFT JOIN groups G ON N.grantee_id = G.id
         LEFT JOIN sites S ON G.site_id = S.id
         LEFT JOIN views V ON N.authorizable_id = V.id
         LEFT JOIN workbooks W ON V.workbook_id = W.id
         LEFT JOIN projects P ON W.project_id = P.id WHERE N.grantee_type = 'Group' AND N.authorizable_type = 'View' AND P.name is not NULL
         UNION
         SELECT N.authorizable_type AS "Object Type", N.grantee_id AS "Is _users.id/groups.id", N.grantee_type AS "Is User/Group", N.capability_id, S.name AS "Site", S.id AS "site_id",
             CASE
                 WHEN N.permission = 1 THEN 'Grant'
                 WHEN N.permission = 2 THEN 'Deny'
                 WHEN N.permission = 3 THEN 'Grant'
                 WHEN N.permission = 4 THEN 'Deny' ELSE NULL
             END AS "Base Authorization",
         U.friendly_name as "Friendly Name", V.name as "Object Name", P.name as "Project", W.name as "Workbook", V.name as "View"
         FROM next_gen_permissions N
         LEFT JOIN _users U ON N.grantee_id = U.id
         LEFT JOIN sites S ON U.site_id = S.id
         LEFT JOIN views V ON N.authorizable_id = V.id
         LEFT JOIN workbooks W ON V.workbook_id = W.id
         LEFT JOIN projects P ON W.project_id = P.id WHERE N.grantee_type = 'User' AND N.authorizable_type = 'Workbook' AND P.name is not NULL
         ) X
         LEFT JOIN capabilities C ON X.capability_id = C.id
     ) DM
         LEFT JOIN
             (SELECT system_users.name AS user_name, system_users.id AS system_user_id, users.id AS user_id, sites.id AS site_id,
                CASE
                    WHEN system_users.admin_level = 10 THEN 1
                    ELSE 0
                    END AS "Is SysAdmin",
                    CASE
                    WHEN system_users.admin_level = 5 THEN 1
                    ELSE 0
                END AS "Is SiteAdmin"
              FROM system_users, users, sites
              WHERE users.site_id = sites.id
              AND users.system_user_id = system_users.id) RC
ON ( DM."site_id" = RC.site_id AND DM."Is _users.id/groups.id" = RC.user_id AND DM."Is User/Group" = 'User' )
