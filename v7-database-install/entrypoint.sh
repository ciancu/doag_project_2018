#!/bin/bash

unzip /tmp/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /
unzip /tmp/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip -d /

export SQLPLUS=/instantclient_12_1/sqlplus
export SQLPLUS_ARGS="${USER}/${PASS}@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=${HOST})(Port=${PORT}))(CONNECT_DATA=(SID=${SID}))) as sysdba"
export SQLPLUS_ARGS_ONEPOINT="${ONEPOINT_USER}/${ONEPOINT_PASS}@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=${HOST})(Port=${PORT}))(CONNECT_DATA=(SID=${SID})))"
export SQLPLUS_ARGS_CONFERENCE="${CONFERENCE_USER}/${CONFERENCE_PASS}@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=${HOST})(Port=${PORT}))(CONNECT_DATA=(SID=${SID})))"

verify(){
	echo "exit" | ${SQLPLUS} -L $SQLPLUS_ARGS | grep Connected > /dev/null
	if [ $? -eq 0 ];
	then
	   echo "Database Connetion is OK"
	else
	   echo -e "Database Connection Failed. Connection failed with:\n $SQLPLUS -S $SQLPLUS_ARGS\n `$SQLPLUS -S $SQLPLUS_ARGS` < /dev/null"
	   echo -e "run example:\n docker run -it --rm --volumes-from $oracle_db_name:oracle-database --link $oracle_db_name:oracle-database v7-database-install install"
	   exit 1
	fi

	if [ "$(ls -A /u01/app/oracle)" ]; then
		echo "Check Database files folder: OK"
	else
		echo -e "Failed to find database files, run example:\n docker run -it --rm --volumes-from $oracle_db_name:oracle-database --link $oracle_db_name:oracle-database v7-database-install install"
		exit 1
	fi
}

get_oracle_home(){
	echo "Getting ORACLE_HOME Path"
	ORACLE_HOME=`echo -e "var ORACLEHOME varchar2(200);\n EXEC dbms_system.get_env('ORACLE_HOME', :ORACLEHOME);\n PRINT ORACLEHOME;" | $SQLPLUS -S $SQLPLUS_ARGS | grep "/.*/"`
	echo "ORACLE_HOME found: $ORACLE_HOME"
}

v7_database_install(){
	cd /scripts
	echo "Droping schemas..."
	$SQLPLUS -S $SQLPLUS_ARGS @clean/drop_users_ts < /dev/null
	echo "Creating schemas..."
	$SQLPLUS -S $SQLPLUS_ARGS @000_create_all < /dev/null
}

v7_database_import_dumps(){
	echo "Import Onepoint"
	$SQLPLUS -S $SQLPLUS_ARGS_ONEPOINT @imports/001_import_onepoint < /dev/null
}
v7_database_update_dbs(){
	echo "Update schema Onepoint..."
	$SQLPLUS -S $SQLPLUS_ARGS_ONEPOINT @onepoint/000_update_onepoint < /dev/null
	echo "Update schema Conference..."
	$SQLPLUS -S $SQLPLUS_ARGS_CONFERENCE @conference/000_update_conference < /dev/null
	echo "Give grants..."
	$SQLPLUS -S $SQLPLUS_ARGS @sys_grants/000_update_grants < /dev/null
	echo "Install Apex application: INT2018-APPS-ADMIN ..."
	$SQLPLUS -S $SQLPLUS_ARGS @apex180100/000_install_appex_app < /dev/null
	$SQLPLUS -S $SQLPLUS_ARGS_ONEPOINT @apex180100/004_f101 < /dev/null
	$SQLPLUS -S $SQLPLUS_ARGS_ONEPOINT @apex180100/005_web_credentials.sql < /dev/null
	echo "Compile invalid Onepoint objects ..."
	$SQLPLUS -S $SQLPLUS_ARGS @999_compile_invalid < /dev/null
}
unzip_scripts(){
	echo "Extracting Scripts"
	unzip /tmp/scripts.zip -d /
	rm -f /tmp/scripts.zip
}
unzip_dumps(){
	echo "Extracting Dumps"
	unzip /tmp/dumps.zip -d /
	rm -f /tmp/dumps.zip
	cp /dumps/*.dmp /u01/app/oracle/admin/xe/dpdump/
}
unzip_certs(){
	echo "Extracting certs"
	unzip /tmp/certs.zip -d /
	rm -f /tmp/certs.zip
	mkdir /u01/app/oracle/certs
	cp /certs/*.* /u01/app/oracle/certs
	chown oracle -R /u01/app/oracle/certs
	chgrp dba -R /u01/app/oracle/certs
}

finish(){
	echo "It should be done but... please check the logs for errors!"
}

case $1 in
	'install')
		verify
		unzip_scripts
		unzip_dumps
		unzip_certs
		v7_database_install
		v7_database_import_dumps
		v7_database_update_dbs
		finish
		;;
	*)
		$1
		;;
esac

/bin/bash