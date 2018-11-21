begin 
 FOR cur IN (SELECT OBJECT_NAME, OBJECT_TYPE, owner 
			 FROM sys.all_objects 
			 WHERE object_type in ('VIEW', 'TRIGGER', 'PROCEDURE', 'SEQUENCE', 'PACKAGE', 'PACKAGE BODY', 'SYNONYM', 'FUNCTION','TYPE')
			 and (owner IN ('U_ONEPOINT_V7'))
			 AND status = 'INVALID' ) LOOP 
	BEGIN
		 if upper(cur.OBJECT_TYPE) = 'PACKAGE BODY' then 
			EXECUTE IMMEDIATE 'alter PACKAGE "' ||  cur.owner || '"."' || cur.OBJECT_NAME || '" compile body'; 
		 else 
			EXECUTE IMMEDIATE 'alter ' || cur.OBJECT_TYPE || ' "' ||  cur.owner || '"."' || cur.OBJECT_NAME || '" compile'; 
		 end if; 
	EXCEPTION
		WHEN OTHERS THEN NULL; 
	END;
 end loop; 

 end;
/

set wrap off 
set linesize 200
COLUMN OWNER FORMAT A25 
SELECT OBJECT_TYPE, OWNER , OBJECT_NAME
			 FROM sys.all_objects 
			 WHERE object_type in ('VIEW', 'TRIGGER', 'PROCEDURE', 'SEQUENCE', 'PACKAGE', 'PACKAGE BODY', 'SYNONYM', 'FUNCTION','TYPE')
			 and (owner IN ('U_ONEPOINT_V7'))
			 AND status = 'INVALID'
/
exit;