-- Z --
WITH Z as
((
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
)),
-- W --
W as
(
select ww.id as wuid, ww.created_at as w_created_at, ww.name as w_name, ww.workbook_url as w_url, ww.project_id, ww.view_count as w_view_count, ww.owner_id as w_owner_id, ww.owner_name as w_owner_name, ww.system_user_id as w_sys_user_id, ww.site_id as w_site_id,
p.id as puid, p.name as p_name, p.owner_id as p_owner_id, p.created_at as p_created_at, p.description as project_desc, p.site_id as p_site_id
from _workbooks ww
inner join projects p on ww.project_id = p.id
),
-- V --
V as
(
  select vv.id as uid, vv.name as v_name, vv.view_url as v_url, vv.created_at as v_created_at, vv.owner_id as v_owner_id, vv.owner_name as v_owner_name, vv.workbook_id as v_w_id, vv.title as v_title, vv.site_id as v_site_id
  , s.id as suid, s.name as s_name, s.url_namespace as s_url
  , t.tag_name, t.tag_id as tuid, t.object_name
  from _views vv
  inner join _sites s on vv.site_id = s.id
  inner join _tags t on vv.id = t.object_id
)
select vs.users_id as vs_users_id, vs.system_users_name as vs_sys_users_name, vs.system_users_friendly_name as vs_sys_users_friendly_name, vs.views_id as vs_v_id, vs.views_name as vs_v_name, vs.views_url as vs_v_url, vs.site_id as vs_site_id,
u.*,
v.*,
w.*,
Z.*
from _views_stats vs
inner join _users u on vs.users_id = u.id
inner join v on vs.views_id = v.uid
inner join w on v.v_w_id = w.wuid
