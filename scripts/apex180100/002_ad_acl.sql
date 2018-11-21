BEGIN
    DBMS_NETWORK_ACL_ADMIN.drop_acl (
    acl          => 'v7_azure_acl_file.xml'); 
    
end;
/

DECLARE
v_count NUMBER;
BEGIN

	SELECT COUNT (1) INTO v_count FROM dba_users WHERE username = UPPER ('APEX_180200');
    IF v_count != 0
    THEN
	   DBMS_NETWORK_ACL_ADMIN.create_acl (
			acl          => 'v7_azure_acl_file.xml', 
			description  => 'ACL to grant access to virtual7 AD server',
			principal    => 'APEX_180200',
			is_grant     => TRUE, 
			privilege    => 'connect',
			start_date   => SYSTIMESTAMP,
			end_date     => NULL);
	
	else
	   DBMS_NETWORK_ACL_ADMIN.create_acl (
			acl          => 'v7_azure_acl_file.xml', 
			description  => 'ACL to grant access to virtual7 AD server',
			principal    => 'APEX_180100',
			is_grant     => TRUE, 
			privilege    => 'connect',
			start_date   => SYSTIMESTAMP,
			end_date     => NULL);
	end if;

    DBMS_NETWORK_ACL_ADMIN.assign_acl (
        acl         => 'v7_azure_acl_file.xml',
        host        => 'keycloak', 
        lower_port  => 9080,
        upper_port  => NULL);
		
    DBMS_NETWORK_ACL_ADMIN.ADD_PRIVILEGE(
        acl         => 'v7_azure_acl_file.xml',
        principal   => 'U_ONEPOINT_V7',
        is_grant    =>  TRUE,
        privilege   => 'connect');

  COMMIT;
END;
/