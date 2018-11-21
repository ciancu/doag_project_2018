SPOOL 001_create_onepoint.log

DECLARE
  v_tablespace_path 		VARCHAR2(1024) :=lower('');
  v_tablespace_name 		VARCHAR2(1024) :=lower('TS_ONEPOINT_V7');
  v_user_name	 			VARCHAR2(1024) :=lower('U_ONEPOINT_V7');
  v_user_name_TRAVEL		VARCHAR2(1024) :=lower('U_ONEPOINT_TRAVEL');
  v_user_name_DWH			VARCHAR2(1024) :=lower('U_V7DWH');
  v_role_name_BENDER		VARCHAR2(1024) :=lower('BENDER');
  v_user_password	 		VARCHAR2(1024) :=lower('welcome1');
  v_count               	number;
BEGIN
	SELECT COUNT (1) INTO v_count FROM dba_users WHERE username = UPPER (v_user_name);
    IF v_count != 0
    THEN
         EXECUTE IMMEDIATE 'DROP USER '||v_user_name||' cascade';
    END IF;
	
	SELECT COUNT (1) INTO v_count FROM dba_users WHERE username = UPPER (v_user_name_TRAVEL);
    IF v_count != 0
    THEN
         EXECUTE IMMEDIATE 'DROP USER '||v_user_name_TRAVEL||' cascade';
    END IF;
	
	SELECT COUNT (1) INTO v_count FROM dba_users WHERE username = UPPER (v_user_name_DWH);
    IF v_count != 0
    THEN
         EXECUTE IMMEDIATE 'DROP USER '||v_user_name_DWH||' cascade';
    END IF;
		
	SELECT COUNT (1) INTO v_count FROM dba_roles WHERE role = UPPER (v_role_name_BENDER);
    IF v_count != 0
    THEN
         EXECUTE IMMEDIATE 'DROP ROLE '||v_role_name_BENDER;
    END IF;
    
    SELECT COUNT (1) INTO v_count FROM dba_tablespaces WHERE tablespace_name = UPPER (v_tablespace_name);
    IF v_count != 0
    THEN
         EXECUTE IMMEDIATE 'DROP TABLESPACE '||v_tablespace_name||' INCLUDING CONTENTS';
    END IF;
	
	EXECUTE IMMEDIATE 'CREATE TABLESPACE '||v_tablespace_name||' LOGGING DATAFILE '''||v_tablespace_path||v_tablespace_name||'.dbf'||''' SIZE 50M REUSE AUTOEXTEND ON';
	EXECUTE IMMEDIATE 'CREATE USER '||v_user_name||' PROFILE "DEFAULT" IDENTIFIED BY "'||v_user_password||'" DEFAULT TABLESPACE '||v_tablespace_name||' ACCOUNT UNLOCK';

	EXECUTE IMMEDIATE 'CREATE USER '||v_user_name_TRAVEL||' PROFILE "DEFAULT" IDENTIFIED BY "'||v_user_password||'" DEFAULT TABLESPACE '||v_tablespace_name||' ACCOUNT UNLOCK';
	EXECUTE IMMEDIATE 'CREATE USER '||v_user_name_DWH||' PROFILE "DEFAULT" IDENTIFIED BY "'||v_user_password||'" DEFAULT TABLESPACE '||v_tablespace_name||' ACCOUNT UNLOCK';

	EXECUTE IMMEDIATE 'CREATE ROLE '||v_role_name_BENDER;
  

	EXECUTE IMMEDIATE 'ALTER USER '||v_user_name||' TEMPORARY TABLESPACE TEMP';

	EXECUTE IMMEDIATE 'GRANT "CONNECT" TO '||v_user_name;
	EXECUTE IMMEDIATE 'GRANT "CONNECT" TO '||v_user_name_TRAVEL;
	EXECUTE IMMEDIATE 'GRANT "CONNECT" TO '||v_user_name_DWH;
	EXECUTE IMMEDIATE 'GRANT "CONNECT" TO '||v_role_name_BENDER;
	
	EXECUTE IMMEDIATE 'GRANT "RESOURCE" TO '||v_user_name;
	EXECUTE IMMEDIATE 'GRANT CREATE TABLE TO '||v_user_name;
	EXECUTE IMMEDIATE 'GRANT CREATE VIEW TO '||v_user_name;
	EXECUTE IMMEDIATE 'GRANT CREATE SEQUENCE TO '||v_user_name;
	EXECUTE IMMEDIATE 'GRANT CREATE SYNONYM TO '||v_user_name;
	EXECUTE IMMEDIATE 'GRANT CREATE PROCEDURE TO '||v_user_name;
	EXECUTE IMMEDIATE 'GRANT CREATE TRIGGER TO '||v_user_name;
	EXECUTE IMMEDIATE 'GRANT CREATE TYPE TO '||v_user_name;
	EXECUTE IMMEDIATE 'GRANT CREATE OPERATOR TO '||v_user_name;
	EXECUTE IMMEDIATE 'GRANT CREATE INDEXTYPE TO '||v_user_name;
	EXECUTE IMMEDIATE 'GRANT UNLIMITED TABLESPACE TO '||v_user_name;
	EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO '||v_user_name;
  EXECUTE IMMEDIATE 'GRANT IMP_FULL_DATABASE TO '||v_user_name;
  EXECUTE IMMEDIATE 'GRANT EXP_FULL_DATABASE TO '||v_user_name;
  EXECUTE IMMEDIATE 'GRANT READ,WRITE ON DIRECTORY DATA_PUMP_DIR TO '||v_user_name;
  	
	--define here the grants on other schema objects
END;
/
SPOOL OFF;