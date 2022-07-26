USE perms_example;

WITH RECURSIVE roles_hierarchy_cte AS (

    --query all the roles for the user we care about
    SELECT r.rid AS rid
    FROM perms_example.role_instance r
    INNER JOIN perms_example.identity_role_assignment ira ON r.rid = ira.rid
    WHERE ira.iid = 'aaaaaaaa-1111-1111-1111-111111111111' -- Andy, GM
    
    UNION

    --walk up the tree and find any other parent roles
    SELECT rh.child_rid AS rid
    FROM perms_example.role_hierarchy rh
    INNER JOIN roles_hierarchy_cte rhc ON rhc.rid = rh.parent_rid
)
--SELECT * FROM roles_hierarchy_cte LIMIT 50;

/* get all the permissions that this identity is assigned to directly */
SELECT i.iid, i.identity_name, NULL AS role_name, p.permission_name
FROM perms_example.identity_instance i
INNER JOIN perms_example.identity_permission_assignment ipa on i.iid = ipa.iid
INNER JOIN perms_example.permission_instance p on ipa.pid = p.pid
WHERE i.iid = 'aaaaaaaa-1111-1111-1111-111111111111' -- Andy, GM
AND p.pid = 'cccccccc-1111-1111-1111-111111111111' -- 'Read Customer Data

UNION ALL

/* also, get any permissions that this identity picks up due to role permissions
     and also role permissions from the role hierarchy */
SELECT i.iid, i.identity_name, r.role_name, p.permission_name
FROM perms_example.role_instance r
INNER JOIN perms_example.role_permission_assignment rpa on r.rid = rpa.rid
INNER JOIN perms_example.permission_instance p on rpa.pid = p.pid
--get me 1 identity row so I can include that on the output
CROSS JOIN
(
        SELECT i.iid, i.identity_name
        FROM perms_example.identity_instance i
        WHERE i.iid = 'aaaaaaaa-1111-1111-1111-111111111111' --Andy, GM
) i
WHERE r.rid IN (
    SELECT rhc.rid
    FROM roles_hierarchy_cte rhc
)
AND p.pid = 'cccccccc-1111-1111-1111-111111111111' -- 'view customer data
;

