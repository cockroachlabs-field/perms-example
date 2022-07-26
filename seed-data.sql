USE perms_example;

/*
TRUNCATE TABLE perms_example.identity_role_assignment;
TRUNCATE TABLE perms_example.role_permission_assignment;
TRUNCATE TABLE perms_example.role_permission_assignment;
TRUNCATE TABLE perms_example.role_hierarchy;
TRUNCATE TABLE perms_example.identity_instance CASCADE;
TRUNCATE TABLE perms_example.role_instance CASCADE;
TRUNCATE TABLE perms_example.permission_instance CASCADE;
*/

INSERT INTO perms_example.identity_instance ( iid, identity_name )
VALUES
( 'aaaaaaaa-1111-1111-1111-111111111111', 'Andy, General Manager' ),
( 'aaaaaaaa-2222-2222-2222-222222222222', 'Pam, Data Entry Supervisor' ),
( 'aaaaaaaa-3333-3333-3333-333333333333', 'Fran, Data Entry, Customer' ),
( 'aaaaaaaa-4444-4444-4444-444444444444', 'Edward, Data Entry, Sales' ),
( 'aaaaaaaa-5555-5555-5555-555555555555', 'Carl, DBA, Customers' ),
( 'aaaaaaaa-6666-6666-6666-666666666666', 'Sally, DBA, Sales' ),
( 'aaaaaaaa-7777-7777-7777-777777777777', 'Rachel, Reporting Analyst' )
;

INSERT INTO perms_example.role_instance ( rid, role_name )
VALUES
( 'bbbbbbbb-1111-1111-1111-111111111111', 'Sales Reader' ),
( 'bbbbbbbb-2222-2222-2222-222222222222', 'Sales Editor' ),
( 'bbbbbbbb-3333-3333-3333-333333333333', 'Sales Admin' ),
( 'bbbbbbbb-4444-4444-4444-444444444444', 'Customer Reader' ),
( 'bbbbbbbb-5555-5555-5555-555555555555', 'Customer Editor' ),
( 'bbbbbbbb-6666-6666-6666-666666666666', 'Customer Admin' ),
( 'bbbbbbbb-7777-7777-7777-777777777777', 'Global Viewer' ),
( 'bbbbbbbb-8888-8888-8888-888888888888', 'Global Editor' ),
( 'bbbbbbbb-9999-9999-9999-999999999999', 'Global Admin' )

;

INSERT INTO perms_example.permission_instance ( pid, permission_name )
VALUES
( 'cccccccc-1111-1111-1111-111111111111', 'Read Customer Data' ),
( 'cccccccc-2222-2222-2222-222222222222', 'Insert Customer Data' ),
( 'cccccccc-3333-3333-3333-333333333333', 'Delete Customer Data' ),
( 'cccccccc-4444-4444-4444-444444444444', 'Update Customer Data' ),
( 'cccccccc-5555-5555-5555-555555555555', 'Modify Customer Schema' ),
( 'cccccccc-6666-6666-6666-666666666666', 'Read Sales Data' ),
( 'cccccccc-7777-7777-7777-777777777777', 'Insert Sales Data' ),
( 'cccccccc-8888-8888-8888-888888888888', 'Delete Sales Data' ),
( 'cccccccc-9999-9999-9999-999999999999', 'Update Sales Data' ),
( 'cccccccc-0000-0000-0000-000000000000', 'Modify Sales Schema' )
;

--you can assign permissions directly to identities here
-- this gives you some flexibility to do one-off assignments
-- you don't actually need any entries here
INSERT INTO perms_example.identity_permission_assignment ( iid, pid )
VALUES
( 'aaaaaaaa-7777-7777-7777-777777777777', 'cccccccc-4444-4444-4444-444444444444' ) --identity: Rachel <--> role: Update Customer Data
;

INSERT INTO perms_example.role_permission_assignment ( rid, pid )
VALUES
( 'bbbbbbbb-1111-1111-1111-111111111111', 'cccccccc-6666-6666-6666-666666666666' ), --role: Sales Reader <--> perm: Read Sales Data

( 'bbbbbbbb-2222-2222-2222-222222222222', 'cccccccc-7777-7777-7777-777777777777' ), --role: Sales Editor <--> perm: Insert Sales Data
( 'bbbbbbbb-2222-2222-2222-222222222222', 'cccccccc-9999-9999-9999-999999999999' ), --role: Sales Editor <--> perm: Update Sales Data
( 'bbbbbbbb-2222-2222-2222-222222222222', 'cccccccc-8888-8888-8888-888888888888' ), --role: Sales Editor <--> perm: Delete Sales Data
( 'bbbbbbbb-2222-2222-2222-222222222222', 'cccccccc-6666-6666-6666-666666666666' ), --role: Sales Editor <--> perm: Read Sales Data

( 'bbbbbbbb-4444-4444-4444-444444444444', 'cccccccc-1111-1111-1111-111111111111' ), --role: Customer Reader <--> perm: Read Customer Data

( 'bbbbbbbb-5555-5555-5555-555555555555', 'cccccccc-2222-2222-2222-222222222222' ), --role: Customer Editor <--> perm: Insert Customer Data
( 'bbbbbbbb-5555-5555-5555-555555555555', 'cccccccc-3333-3333-3333-333333333333' ), --role: Customer Editor <--> perm: Update Customer Data
( 'bbbbbbbb-5555-5555-5555-555555555555', 'cccccccc-4444-4444-4444-444444444444' ), --role: Customer Editor <--> perm: Delete Customer Data
( 'bbbbbbbb-5555-5555-5555-555555555555', 'cccccccc-1111-1111-1111-111111111111' ), --role: Customer Editor <--> perm: Read Customer Data

( 'bbbbbbbb-3333-3333-3333-333333333333', 'cccccccc-0000-0000-0000-000000000000' ), --role: Sales Admin <--> perm: Modify Sales Schema

( 'bbbbbbbb-6666-6666-6666-666666666666', 'cccccccc-5555-5555-5555-555555555555' )  --role: Customer Admin <--> perm: Modify Customer Schema
;

INSERT INTO perms_example.role_hierarchy ( parent_rid, child_rid )
VALUES
( 'bbbbbbbb-3333-3333-3333-333333333333', 'bbbbbbbb-2222-2222-2222-222222222222' ), -- role: Sales Admin <-- role: Sales Editor

( 'bbbbbbbb-6666-6666-6666-666666666666', 'bbbbbbbb-5555-5555-5555-555555555555' ), -- role: Customer Admin <-- role: Customer Editor

( 'bbbbbbbb-9999-9999-9999-999999999999', 'bbbbbbbb-6666-6666-6666-666666666666' ), -- role: Global Admin <-- role: Customer Admin
( 'bbbbbbbb-9999-9999-9999-999999999999', 'bbbbbbbb-3333-3333-3333-333333333333' ), -- role: Global Admin <-- role: Sales Admin

( 'bbbbbbbb-7777-7777-7777-777777777777', 'bbbbbbbb-4444-4444-4444-444444444444' ), -- role: Global Viewer <-- role: Customer Reader
( 'bbbbbbbb-7777-7777-7777-777777777777', 'bbbbbbbb-1111-1111-1111-111111111111' )  -- role: Global Viewer <-- role: Sales Reader
;

INSERT INTO perms_example.identity_role_assignment ( iid, rid )
VALUES
( 'aaaaaaaa-1111-1111-1111-111111111111', 'bbbbbbbb-9999-9999-9999-999999999999' ), --identity: Andy, General Manager <--> role: Global Admin
( 'aaaaaaaa-2222-2222-2222-222222222222', 'bbbbbbbb-8888-8888-8888-888888888888' ), --identity: Pam, Data Entry Supervisor <--> role: Global Editor
( 'aaaaaaaa-3333-3333-3333-333333333333', 'bbbbbbbb-5555-5555-5555-555555555555' ), --identity: Fran, Data Entry, Customer <--> role: Customer Editor
( 'aaaaaaaa-4444-4444-4444-444444444444', 'bbbbbbbb-2222-2222-2222-222222222222' ), --identity: Edward, Data Entry, Sales <--> role: Sales Editor
( 'aaaaaaaa-5555-5555-5555-555555555555', 'bbbbbbbb-6666-6666-6666-666666666666' ), --identity: Carl, DBA, Customers <--> role: Customer Admin
( 'aaaaaaaa-6666-6666-6666-666666666666', 'bbbbbbbb-3333-3333-3333-333333333333' ), --identity: Sally, DBA, Sales <--> role: Update Customer Data
( 'aaaaaaaa-7777-7777-7777-777777777777', 'bbbbbbbb-7777-7777-7777-777777777777' )  --identity: Rachel, Reporting Analyst <--> role: Global Viewer
;
