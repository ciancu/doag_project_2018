set scan off
set serveroutput on
set escape off
whenever sqlerror exit 
DECLARE
    h1 number;
    errorvarchar varchar2(100):= 'ERROR';
    tryGetStatus number := 0;
	v_count      number;
	job_state	 varchar2(100);
begin
	
	SELECT COUNT (1) INTO v_count FROM user_tables WHERE UPPER(table_name) = UPPER ('IMPORT_JOB_ONEPOINT');
    IF v_count != 0
    THEN
         EXECUTE IMMEDIATE 'drop table "IMPORT_JOB_ONEPOINT" cascade constraints PURGE';
    END IF;
	
	SELECT COUNT (1) INTO v_count FROM user_tables WHERE UPPER(table_name) = UPPER ('SYS_EXPORT_SCHEMA_01');
    IF v_count != 0
    THEN
         EXECUTE IMMEDIATE 'drop table "SYS_EXPORT_SCHEMA_01" cascade constraints PURGE';
    END IF;
    
    h1 := dbms_datapump.open (operation => 'IMPORT', job_mode => 'FULL', job_name => 'IMPORT_JOB_ONEPOINT', version => 'COMPATIBLE'); 
    tryGetStatus := 1;
    dbms_datapump.set_parallel(handle => h1, degree => 1); 
    dbms_datapump.add_file(handle => h1, filename => 'IMPORT.LOG', directory => 'DATA_PUMP_DIR', filetype => 3); 
    dbms_datapump.set_parameter(handle => h1, name => 'KEEP_MASTER', value => 1); 
    dbms_datapump.add_file(handle => h1, filename => 'ONEPOINT.dmp', directory => 'DATA_PUMP_DIR', filetype => 1); 
    dbms_datapump.set_parameter(handle => h1, name => 'INCLUDE_METADATA', value => 1); 
    dbms_datapump.set_parameter(handle => h1, name => 'DATA_ACCESS_METHOD', value => 'AUTOMATIC'); 
    dbms_datapump.set_parameter(handle => h1, name => 'REUSE_DATAFILES', value => 0); 
    dbms_datapump.set_parameter(handle => h1, name => 'SKIP_UNUSABLE_INDEXES', value => 0);
    dbms_datapump.start_job(handle => h1, skip_current => 0, abort_step => 0); 
	dbms_datapump.WAIT_FOR_JOB(handle => h1, job_state => job_state);
	dbms_output.put_line('Job finished with state:'||job_state);
    dbms_datapump.detach(handle => h1); 
    errorvarchar := 'NO_ERROR'; 
EXCEPTION
    WHEN OTHERS THEN
    BEGIN 
        IF ((errorvarchar = 'ERROR')AND(tryGetStatus=1)) THEN 
            DBMS_DATAPUMP.DETACH(h1);
        END IF;
    EXCEPTION 
    WHEN OTHERS THEN 
        NULL;
    END;
    RAISE;
END;
/
