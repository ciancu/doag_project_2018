DECLARE
   n_security_group NUMBER;
   v_count NUMBER;
BEGIN

SELECT COUNT (1) INTO v_count FROM dba_users WHERE username = UPPER ('APEX_180100');
    IF v_count != 0
    THEN

		 EXECUTE IMMEDIATE 'alter session set current_schema = APEX_180100';

		 SELECT workspace_id
		  INTO n_security_group
		  FROM apex_workspaces
		  WHERE workspace = 'INT2018-APPS-ADMIN';
		   wwv_flow_api.set_security_group_id(n_security_group );
		   
			apex_credential.set_persistent_credentials (
				   p_credential_static_id => 'keycloak_credentials',
				   p_client_id            => 'virtual7_app',
				   p_client_secret        => 'web_app' );
		  COMMIT;
	END IF;
END;
/

DECLARE
   n_security_group NUMBER;
   v_count NUMBER;
BEGIN
SELECT COUNT (1) INTO v_count FROM dba_users WHERE username = UPPER ('APEX_180200');
    IF v_count != 0
    THEN

		EXECUTE IMMEDIATE 'alter session set current_schema = APEX_180200';

		 SELECT workspace_id
		  INTO n_security_group
		  FROM apex_workspaces
		  WHERE workspace = 'INT2018-APPS-ADMIN';
		   wwv_flow_api.set_security_group_id(n_security_group );
		   
			apex_credential.set_persistent_credentials (
				   p_credential_static_id => 'keycloak_credentials',
				   p_client_id            => 'virtual7_app',
				   p_client_secret        => 'web_app' );
		  COMMIT;
    END IF;

END;
/